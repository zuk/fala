# Fala #

Advanced scientific/financial data visualization in Flash... someday. 

For now it's a sparse Flex project, with a half-working HLOC chart implementation.

### Where this is going ###

The idea is, you embed the Fala flash component in a web page:

	<embed src="Fala.swf" width="500" height="400">
	</embed>
  
Then you configure it to read JSON data from some arbitrary URL:

	<embed src="Fala.swf" width="500" height="400"
	  flashVars="dataURL=http://example.com/my_data.json">
	</embed>

Add another URL to format and configure your chart:

	<embed src="Fala.swf" width="500" height="400"
	  flashVars="dataURL=http://example.com/my_data.json&configURL=http://example.com/my_config.json">
	</embed>
  
And out comes a beautiful Flash graphic/animation displaying your data.

Something like this already exists ==> [http://pullmonkey.com/projects/open_flash_chart2]

But if Fala is to be a playground for data visualization, basic bar-and-line charts won't 
cut it.

So begins a half-baked project that in all likelyhood will go nowhere.

### Building/Compiling ###

You have here a bunch of MXML and ActionScript source. You want to compile all this into a 
Flash SWF file (Fala.swf).

The easy way is to import the project into Adobe Flex 3. Once you have the project set up in Flex, the Fala.swf file should be built for you 
automagically into the bin-debug subdirectory.

The hard way is to do it through the free-and-open-source Flex SDK, in which case you will need 
patience and knowledge of arcane command line inctantations. Some day I will post instructions. 