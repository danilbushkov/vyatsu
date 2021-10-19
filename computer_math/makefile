$(outputjar): $(filename)
	..\..\programs\kotlinc\bin\kotlinc $(filename) -include-runtime -d $(outputjar)
run: $(outputjar)
	..\..\programs\jdk-13\bin\java -jar $(outputjar)
