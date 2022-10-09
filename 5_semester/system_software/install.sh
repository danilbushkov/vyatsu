wget -P ./archives/ https://github.com/qb40/masm/releases/download/1.0.0/masm.zip
wget -P ./archives/ https://github.com/qb40/tasm/releases/download/1.0.0/tasm.zip


mkdir -p dev/masm
mkdir -p dev/tasm

unzip ./archives/masm.zip -d ./dev/masm/
unzip ./archives/tasm.zip -d ./dev/tasm/


rm -r ./archives/
