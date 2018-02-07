# Off the Shelf API first CMS investigation

Rendering a simple page using the Ruby clients provided
by the following services.

- ButterCMS
- Contentful
- Contentstack

## Usage

1. create a .env file with the relevant keys for a given service. 

2. run the service script.   
e.g.
`> Ruby contentstack.rb`

3. view the outuput in the corresponding folder  
e.g.
`> open output/contentstack/xxxxx.html`

### comments from developer

Best Ruby Client:   
Contentful, nicest object model, best dsl for assets

Best Full text treatment:  
Contentful, using markdown will always get high praise :D

Best Asset handling:  
Contnentful/Contentstack - Tie

Best documentation:  
Contentful

Random thoughts: 

- Contentstacks enviroments concept is really good and strikes me as very well suited to an organisation with a good workflow for publishing content.

- Contentful preview api is good but can lead to a very polluted stream as everything ends up here. 

- Contentstack diffing tool is the best out there also allowing you to diff without publishing, not true for other providers



