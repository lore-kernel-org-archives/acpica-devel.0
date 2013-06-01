Content-Type: multipart/mixed; boundary="===============2406645340353635608=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: acpidump -- provide initial
 implementation for Linux
Date: Sat, 01 Jun 2013 00:46:37 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE79BBE@ORSMSX103.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2406645340353635608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Al,

We've just completed and checked in a full implementation for Linux.

You might want to inspect the code and see if there is anything that can be=
 or should be merged. The code is at (or near) the head of our git tree.

Thanks,
Bob


> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
> Of Al Stone
> Sent: Friday, May 31, 2013 5:21 PM
> To: devel(a)acpica.org
> Subject: [Devel] [PATCH] ACPICA: acpidump -- provide initial
> implementation for Linux
> =

> =

> source/os_specific/service_layer/oslinuxtbl.c: provide implementations for
> AcpiOsGetTableByName and AcpiOsGetTableByIndex.
> =

> With these two routines implemented, one can now run a Linux version of
> acpidump and dump tables by name, or by index.  An implementation for
> dumping tables by address has not been provided.
> =

> Signed-off-by: Al Stone <ahs3(a)redhat.com>
> ---
>   source/os_specific/service_layers/oslinuxtbl.c | 415
> ++++++++++++++++++-------
>   1 file changed, 304 insertions(+), 111 deletions(-)
> =

> diff --git a/source/os_specific/service_layers/oslinuxtbl.c
> b/source/os_specific/service_layers/oslinuxtbl.c
> index f539693..4005e0d 100644
> --- a/source/os_specific/service_layers/oslinuxtbl.c
> +++ b/source/os_specific/service_layers/oslinuxtbl.c
> @@ -4,123 +4,295 @@
>    *
> =

> **************************************************************************
> ***/
> =

> -
> /*************************************************************************
> *****
> - *
> - * 1. Copyright Notice
> - *
> - * Some or all of this work - Copyright (c) 1999 - 2013, Intel Corp.
> +/*
> + * Copyright (C) 2000 - 2013, Intel Corp.
>    * All rights reserved.
>    *
> - * 2. License
> - *
> - * 2.1. This is your license from Intel Corp. under its intellectual
> property
> - * rights. You may have additional license terms from the party that
> provided
> - * you this software, covering your right to use that party's
> intellectual
> - * property rights.
> - *
> - * 2.2. Intel grants, free of charge, to any person ("Licensee")
> obtaining a
> - * copy of the source code appearing in this file ("Covered Code") an
> - * irrevocable, perpetual, worldwide license under Intel's copyrights in
> the
> - * base code distributed originally by Intel ("Original Intel Code") to
> copy,
> - * make derivatives, distribute, use and display any portion of the
> Covered
> - * Code in any form, with the right to sublicense such rights; and
> - *
> - * 2.3. Intel grants Licensee a non-exclusive and non-transferable patent
> - * license (with the right to sublicense), under only those claims of
> Intel
> - * patents that are infringed by the Original Intel Code, to make, use,
> sell,
> - * offer to sell, and import the Covered Code and derivative works
> thereof
> - * solely to the minimum extent necessary to exercise the above copyright
> - * license, and in no event shall the patent license extend to any
> additions
> - * to or modifications of the Original Intel Code. No other license or
> right
> - * is granted directly or by implication, estoppel or otherwise;
> - *
> - * The above copyright and patent license is granted only if the
> following
> - * conditions are met:
> - *
> - * 3. Conditions
> - *
> - * 3.1. Redistribution of Source with Rights to Further Distribute
> Source.
> - * Redistribution of source code of any substantial portion of the
> Covered
> - * Code or modification with rights to further distribute source must
> include
> - * the above Copyright Notice, the above License, this list of
> Conditions,
> - * and the following Disclaimer and Export Compliance provision. In
> addition,
> - * Licensee must cause all Covered Code to which Licensee contributes to
> - * contain a file documenting the changes Licensee made to create that
> Covered
> - * Code and the date of any change. Licensee must include in that file
> the
> - * documentation of any changes made by any predecessor Licensee.
> Licensee
> - * must include a prominent statement that the modification is derived,
> - * directly or indirectly, from Original Intel Code.
> - *
> - * 3.2. Redistribution of Source with no Rights to Further Distribute
> Source.
> - * Redistribution of source code of any substantial portion of the
> Covered
> - * Code or modification without rights to further distribute source must
> - * include the following Disclaimer and Export Compliance provision in
> the
> - * documentation and/or other materials provided with distribution. In
> - * addition, Licensee may not authorize further sublicense of source of
> any
> - * portion of the Covered Code, and must include terms to the effect that
> the
> - * license from Licensee to its licensee is limited to the intellectual
> - * property embodied in the software Licensee provides to its licensee,
> and
> - * not to intellectual property embodied in modifications its licensee
> may
> - * make.
> - *
> - * 3.3. Redistribution of Executable. Redistribution in executable form
> of any
> - * substantial portion of the Covered Code or modification must reproduce
> the
> - * above Copyright Notice, and the following Disclaimer and Export
> Compliance
> - * provision in the documentation and/or other materials provided with
> the
> - * distribution.
> - *
> - * 3.4. Intel retains all right, title, and interest in and to the
> Original
> - * Intel Code.
> - *
> - * 3.5. Neither the name Intel nor any other trademark owned or
> controlled by
> - * Intel shall be used in advertising or otherwise to promote the sale,
> use or
> - * other dealings in products derived from or relating to the Covered
> Code
> - * without prior written authorization from Intel.
> - *
> - * 4. Disclaimer and Export Compliance
> - *
> - * 4.1. INTEL MAKES NO WARRANTY OF ANY KIND REGARDING ANY SOFTWARE
> PROVIDED
> - * HERE. ANY SOFTWARE ORIGINATING FROM INTEL OR DERIVED FROM INTEL
> SOFTWARE
> - * IS PROVIDED "AS IS," AND INTEL WILL NOT PROVIDE ANY SUPPORT,
> ASSISTANCE,
> - * INSTALLATION, TRAINING OR OTHER SERVICES. INTEL WILL NOT PROVIDE ANY
> - * UPDATES, ENHANCEMENTS OR EXTENSIONS. INTEL SPECIFICALLY DISCLAIMS ANY
> - * IMPLIED WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT AND FITNESS FOR
> A
> - * PARTICULAR PURPOSE.
> - *
> - * 4.2. IN NO EVENT SHALL INTEL HAVE ANY LIABILITY TO LICENSEE, ITS
> LICENSEES
> - * OR ANY OTHER THIRD PARTY, FOR ANY LOST PROFITS, LOST DATA, LOSS OF USE
> OR
> - * COSTS OF PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES, OR FOR ANY
> INDIRECT,
> - * SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THIS AGREEMENT, UNDER
> ANY
> - * CAUSE OF ACTION OR THEORY OF LIABILITY, AND IRRESPECTIVE OF WHETHER
> INTEL
> - * HAS ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES. THESE
> LIMITATIONS
> - * SHALL APPLY NOTWITHSTANDING THE FAILURE OF THE ESSENTIAL PURPOSE OF
> ANY
> - * LIMITED REMEDY.
> - *
> - * 4.3. Licensee shall not export, either directly or indirectly, any of
> this
> - * software or system incorporating such software without first obtaining
> any
> - * required license or other approval from the U. S. Department of
> Commerce or
> - * any other agency or department of the United States Government. In the
> - * event Licensee exports any such software from the United States or
> - * re-exports any such software from a foreign destination, Licensee
> shall
> - * ensure that the distribution and export/re-export of the software is
> in
> - * compliance with all laws, regulations, orders, or other restrictions
> of the
> - * U.S. Export Administration Regulations. Licensee agrees that neither
> it nor
> - * any of its subsidiaries will export/re-export any technical data,
> process,
> - * software, or service, directly or indirectly, to any country for which
> the
> - * United States government or any agency thereof requires an export
> license,
> - * other governmental approval, or letter of assurance, without first
> obtaining
> - * such license, approval or letter.
> - *
> -
> **************************************************************************
> ***/
> + * Linux implementation (vs original module skeleton):
> + * Copyright (c) 2013, Al Stone <ahs3(a)redhat.com>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions, and the following disclaimer,
> + *    without modification.
> + * 2. Redistributions in binary form must reproduce at minimum a
> disclaimer
> + *    substantially similar to the "NO WARRANTY" disclaimer below
> + *    ("Disclaimer") and any redistribution must be conditioned upon
> + *    including a substantially similar Disclaimer requirement for
> further
> + *    binary redistribution.
> + * 3. Neither the names of the above-listed copyright holders nor the
> names
> + *    of any contributors may be used to endorse or promote products
> derived
> + *    from this software without specific prior written permission.
> + *
> + * Alternatively, this software may be distributed under the terms of
> + the
> + * GNU General Public License ("GPL") version 2 as published by the
> + Free
> + * Software Foundation.
> + *
> + * NO WARRANTY
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS
> + FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> + GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + ARISING
> + * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> + * POSSIBILITY OF SUCH DAMAGES.
> + */
> =

>   #include "acpi.h"
> =

> +#include <fcntl.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> =

>   #define _COMPONENT          ACPI_OS_SERVICES
>           ACPI_MODULE_NAME    ("oslinuxtbl")
> =

> +/*
> + * Linux specific code
> + *
> + * Read in all the tables we can find and put them in a nice table at
> + * startup so we don't have to keep doing searches for each table.
> + *
> + */
> +
> +#define ACPI_OS_MAX_TABLE_INDEX	128
> +#define MAX_SIG  5
> +#define MAX_PATH 256
> +#define MAX_BUF  (128*1024)	/* no table bigger than 128 KiB? */
> +#define TABLE_HEADER 256
> +
> +static int tables_found =3D 0;
> +
> +typedef struct table_info {
> +    char *filename;
> +    char signature[MAX_SIG];
> +    int  instance;		/* only for some tables */
> +    int  dynamic;
> +    ACPI_PHYSICAL_ADDRESS address;
> +    int  size;
> +    unsigned char *data;
> +} TABLE_INFO;
> +
> +static TABLE_INFO acpi_tables[ACPI_OS_MAX_TABLE_INDEX];
> +static int next_index =3D 0;
> +
> +/**********************************************************************
> +********
> + *
> + * FUNCTION:    read_table
> + *
> + * PARAMETERS:  fullpath        - absolute path to /sys ACPI table
> + *
> + * RETURN:      If the table can be read, returns 0; returns non-zero
> + * 		otherwise.
> + *
> + * DESCRIPTION: Read in the contents of an ACPI table as stored in
> + * 		/sys/firmware/acpi.  Fill in the contents of an entry
> + * 		in acpi_tables with the size and data of the table.
> + *
> +
> **************************************************************************
> ***/
> +
> +static int
> +read_table(
> +    char *fullpath)
> +{
> +    static unsigned char buf[MAX_BUF];
> +    FILE *fd;
> +    int result;
> +    int cnt;
> +    unsigned char *up;
> +
> +    result =3D 1;
> +
> +    /* read the table once to figure out it's size, then put it in a
> buffer */
> +    memset(buf, 0, MAX_BUF);
> +    fd =3D fopen(fullpath, "r");
> +    if (fd)
> +    {
> +        cnt =3D fread(buf, MAX_BUF, 1, fd);
> +	if (feof(fd))
> +	{
> +	    cnt =3D ftell(fd);
> +	    up =3D (unsigned char *)malloc(cnt);
> +	    if (up)
> +	    {
> +	        memcpy(up, buf, cnt);
> +		acpi_tables[next_index].size =3D cnt;
> +		acpi_tables[next_index].data =3D up;
> +                memcpy(acpi_tables[next_index].signature, up, 4);
> +	        result =3D 0;
> +	    }
> +	}
> +        fclose(fd);
> +    }
> +    else
> +    {
> +        fprintf(stderr, "Cannot open %s\n", fullpath);
> +    }
> +    return (result);
> +}
> +
> +/**********************************************************************
> +********
> + *
> + * FUNCTION:    get_table_info
> + *
> + * PARAMETERS:  dirpath         - absolute path to a /sys/firmware/acpi
> + * 				  directory
> + *
> + * RETURN:      Status: AE_OK if all the ACPI tables in the directory
> + * 		given by dirpath can be read in.  If not, AE_LIMIT will
> + * 		be returned if there is insufficient space for the table,
> + * 		and AE_ERROR otherwise.
> + *
> + * DESCRIPTION: Given a directory path in /sys, read in each of the files
> + * 		in that directory as an ACPI table.  Store any information
> + * 		gathered about the table in an acpi_tables entry.
> + *
> +
> **************************************************************************
> ***/
> +
> +static ACPI_STATUS
> +get_table_info(
> +    char *dirpath)
> +{
> +    ACPI_STATUS result;
> +    void *dir;
> +    char *fpath;
> +    char fullpath[MAX_PATH];
> +    int tmp;
> +    char *p;
> +    struct stat buf;
> +
> +    result =3D AE_ERROR;
> +    dir =3D AcpiOsOpenDirectory(dirpath, "*", REQUEST_FILE_ONLY);
> +    if (dir)
> +    {
> +        fpath =3D AcpiOsGetNextFilename(dir);
> +	while (fpath)
> +	{
> +            memset(fullpath, 0, MAX_PATH);
> +            strcpy(fullpath, dirpath);
> +            strcat(fullpath, "/");
> +            strcat(fullpath, fpath);
> +	    if (next_index >=3D ACPI_OS_MAX_TABLE_INDEX)
> +	    {
> +	        result =3D AE_LIMIT;
> +	        break;
> +	    }
> +	    else
> +	    {
> +	        tmp =3D strlen(fullpath) + 1;
> +		p =3D (char *)malloc(tmp);
> +		if (p)
> +		{
> +		    memset(p, 0, tmp);
> +	            acpi_tables[next_index].filename =3D p;
> +		}
> +		else
> +		{
> +	            result =3D AE_LIMIT;
> +	            break;
> +		}
> +	        strcpy(acpi_tables[next_index].filename, fullpath);
> +
> +	        acpi_tables[next_index].dynamic =3D 0;
> +
> +		if (strlen(fpath) > 4)
> +		{
> +		    tmp =3D strtol(&(fpath[4]), NULL, 10);
> +		    acpi_tables[next_index].instance =3D tmp;
> +		}
> +
> +		if (stat(fullpath, &buf) =3D=3D 0)
> +		{
> +		    if (read_table(fullpath) =3D=3D 0)
> +		    {
> +		        result =3D AE_OK;
> +		    }
> +		    else
> +		    {
> +		        result =3D AE_LIMIT;
> +			break;
> +		    }
> +		}
> +
> +	        next_index++;
> +	    }
> +            fpath =3D AcpiOsGetNextFilename(dir);
> +	}
> +
> +    	AcpiOsCloseDirectory(dir);
> +	result =3D AE_OK;
> +    }
> +    else
> +    {
> +	result =3D AE_ERROR;
> +    }
> +
> +    return (result);
> +}
> +
> +/**********************************************************************
> +********
> + *
> + * FUNCTION:    init_table_info
> + *
> + * PARAMETERS:  none
> + *
> + * RETURN:      Status: AE_OK if initialization was properly done.  If
> + * 		it was not, an error status indicating what occurred.
> + *
> + * DESCRIPTION: This routine is called to set up a file global structure
> + * 		(acpi_tables) that will then be used by the other
> + * 		AcpiOsGetTableBy* routines to find and print out info
> + * 		about one of the current systems ACPI tables.  The
> + * 		routine is also set up so that it should only do the
> + * 		heavy initialization work once on first being called.
> + *
> +
> **************************************************************************
> ***/
> +
> +static ACPI_STATUS
> +init_table_info(
> +    void)
> +{
> +    ACPI_STATUS result;
> +
> +    if (tables_found)
> +       	return (AE_OK);
> +
> +    /* must be superuser to read the tables */
> +    if (getuid() !=3D 0)
> +    {
> +        fprintf(stderr, "Must be run as superuser\n");
> +	return (AE_SUPPORT);
> +    }
> +
> +    /* basic initialization */
> +    memset(acpi_tables, 0, ACPI_OS_MAX_TABLE_INDEX *
> + sizeof(TABLE_INFO));
> +
> +    /*
> +     * Look for all the files in /sys/firmware/acpi/tables and in
> +     * /sys/firmware/acpi/tables/dynamic; each one is a table.
> +     */
> +    result =3D get_table_info("/sys/firmware/acpi/tables");
> +    if (result =3D=3D AE_OK)
> +    {
> +        result =3D get_table_info("/sys/firmware/acpi/tables/dynamic");
> +    }
> +
> +    if (result =3D=3D AE_OK)
> +    {
> +        tables_found =3D 1;
> +    }
> +    return (result);
> +}
> =

> =

> /*************************************************************************
> *****
>    *
> @@ -170,9 +342,16 @@ AcpiOsGetTableByIndex (
>       ACPI_TABLE_HEADER       **Table,
>       ACPI_PHYSICAL_ADDRESS   *Address)
>   {
> -
> -    fprintf (stderr, "Linux version not implemented yet\n");
> -    return (AE_SUPPORT);
> +    if (init_table_info() =3D=3D AE_OK)
> +    {
> +        if (Index < next_index)
> +        {
> +            *Table =3D (ACPI_TABLE_HEADER *)acpi_tables[Index].data;
> +	    *Address =3D 0;
> +	    return (AE_OK);
> +        }
> +    }
> +    return (AE_LIMIT);
>   }
> =

> =

> @@ -203,7 +382,21 @@ AcpiOsGetTableByName (
>       ACPI_TABLE_HEADER       **Table,
>       ACPI_PHYSICAL_ADDRESS   *Address)
>   {
> +    int ii;
> =

> -    fprintf (stderr, "Linux version not implemented yet\n");
> -    return (AE_SUPPORT);
> +    if (init_table_info() =3D=3D AE_OK)
> +    {
> +        for (ii =3D 0; ii < next_index; ii++)
> +	{
> +	    if ((strncmp(Signature, acpi_tables[ii].signature, 4) =3D=3D 0) &&
> +	        (acpi_tables[ii].instance =3D=3D Instance))
> +	    {
> +	        *Table =3D (ACPI_TABLE_HEADER *)acpi_tables[ii].data;
> +		*Address =3D 0;
> +		return (AE_OK);
> +	    }
> +	}
> +	return (AE_LIMIT);
> +    }
> +    return (AE_NOT_FOUND);
>   }
> --
> 1.8.1.4
> =

> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3(a)redhat.com
> -----------------------------------
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============2406645340353635608==--

