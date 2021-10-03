app.jar: test.kt
	..\..\programs\kotlinc\bin\kotlinc test.kt -include-runtime -d app.jar
run: app.jar
	..\..\programs\jdk-13\bin\java -jar app.jar
