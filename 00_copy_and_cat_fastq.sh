#! /bin/env sh
#
# Take files from an INDIR directory, and concatenate all those
# with the same prefix and matching 'R#' index together, outputting them
# to another directory
#
# Copyright (C) 2019  Mark Einon <mark.einon@gmail.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License,
# Version 2.1 only as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#

DD='/scratch/c.c1117174/cfc_trap/input/'
INDIR='/gluster/neurocluster/sequencers/Natalie_Meeson/cfc_acquisition/files/'

# Perform the ls just the once, to speed things up...
INDIR_LS=`ls ${INDIR}`

# Get a list of unique file prefixes, from the start of the string to the first '_R' characters
PREFIXES=`for DIR in ${INDIR_LS[@]}; do echo ${DIR}; done | grep 'fastq.gz' | sed 's/\(^.*_\)R[0-9]*_.*$/\1/' | uniq`

for INDEX in {1..2}; do
    for PREFIX in ${PREFIXES[@]}; do
        echo Creating file ${PREFIX}${INDEX}.fastq.gz
        FILES=""
        for DIR in ${INDIR_LS[@]}; do
            FILES+=`echo ${DIR} | grep ${PREFIX} | grep "_R${INDEX}_" | sed "s|^|${INDIR}/|" | sed 's/$/ /'`
        done

        # Take the set of matching files found and cat them to a new file
        cat ${FILES} > ${DD}/${PREFIX}${INDEX}.fastq.gz

    done
done

