#!/bin/bash
set -x

# Merge md files
mkdir -p build
cd build

RESF="Compiler_Answers_Total.md"
rm -rf $RESF
for i in `ls -d ../ch*/*`; do
    echo $i
    cat $i/*.md >> $RESF
    
    DIR_ASS=${i}/assets
    if [ -d "$DIR_ASS" ]; then
        cp -r $DIR_ASS .
    fi

done


# Export to pdf.
# Ref: https://tomshine.hashnode.dev/markdown-pdf
sudo apt install pandoc -y
# Install xetex, wait for long time.
sudo apt install texlive-xetex latex-cjk-all -y

# To find supported chinese font, run: fc-list :lang=zh 
pandoc --pdf-engine=xelatex -V CJKmainfont="AR PL KaitiM GB" \
       --toc -N -o ${RESF%.*}.pdf  $RESF
