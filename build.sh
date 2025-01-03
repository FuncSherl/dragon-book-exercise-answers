#!/bin/bash
# set -x

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

echo "Installing pandoc and depends..."
# Export to pdf.
# Ref: https://tomshine.hashnode.dev/markdown-pdf
sudo apt install pandoc -y
# Install xetex, wait for long time.
sudo apt install texlive-xetex latex-cjk-all -y

# To find supported chinese font, run: fc-list :lang=zh 
# CJKmainfont: Noto Serif CJK SC  # 设置正文中文字体
# CJKsansfont: Noto Sans CJK SC   # 设置无衬线中文字体（可选）
# CJKmonofont: Sarasa Mono SC     # 设置代码块中文字体
# mainfont: Times New Roman       # 设置正文英文字体
# sansfont: Arial                 # 设置无衬线英文字体（可选）
# monofont: Courier New           # 设置代码块英文字体
# 如果不指定CJKsansfont，当table中出现中文时就会报该文字找不到

# Ubuntu 自带了一些高质量的无衬线字体，可以直接使用：
# Ubuntu：Ubuntu 的默认字体，现代且清晰。
# Ubuntu Condensed：Ubuntu 字体的紧缩版本，适合标题或紧凑排版。
# Liberation Sans：与 Arial 类似的开源字体，兼容性好。
# DejaVu Sans：支持多种语言，包括中文、日文和韩文（CJK）。
# 这些字体通常已经预装在 Ubuntu 中。如果没有，可以通过以下命令安装：
# sudo apt install fonts-ubuntu fonts-liberation ttf-dejavu

# Google 的 Noto 字体家族是一个高质量的开源字体集合，支持几乎所有语言（包括中文、日文、韩文等）。
# Noto Sans：无衬线字体，设计简洁现代。
# Noto Sans CJK：专为中、日、韩文设计的无衬线字体。
# 安装如下：
# sudo apt install fonts-noto fonts-noto-cjk

echo "Start generating pdf..."

set -x
pandoc --pdf-engine=xelatex -V CJKmainfont="Noto Serif CJK SC" \
       -V CJKmonofont="Sarasa Mono SC" \
       -V CJKsansfont="Noto Sans CJK SC" \
       -V mainfont="DejaVu Sans" \
       -V sansfont="DejaVu Sans" \
       -V monofont="Noto Sans Mono" \
       --toc -o ${RESF%.*}.pdf  $RESF
set +x

echo "Finish pdf generating: "${RESF%.*}.pdf
