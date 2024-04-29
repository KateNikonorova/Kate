#!/bin/bash


rename()
{
    local file=$1 chr=$2
    echo "$file" | sed 's/^\([^.]*\)/\1'$chr'/'
}

inDir=$1
outDir=$2

if ! [ -d "$inDir" ]; then
    echo 'Input directory does not exist'
    exit 1
fi

if [ "$inDir" = "$outDir" ]; then
    echo 'Name of input directory equals name of output directory, please rename output directory'
    exit 1
fi

if ! [ -d "$outDir" ]; then
    echo 'Output directory does not exist'
    echo 'Create output directory'
    mkdir $outDir
    echo 'Continue work of script:'
fi


find "$inDir" -type f | sort | while read file; do
    outFile="$outDir/`basename "$file"`"
    i=0
    while [ -f "$outFile" ]; do
        outFile=`rename "$outFile" "_$i"`
        ((i=i+1))
    done
    echo "copy $file to $outFile"
    cp "$file" "$outFile"
done

exit 0
