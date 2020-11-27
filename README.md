# APIMATIC Transformer Action

This [Github Action](https://github.com/actions) uploads and converts any API Specification into one of the supported formats listed [here](https://www.apimatic.io/transformer/#supported-formats).

## API Description Format
### A format is a unique identifier for transformation. E.g. swagger, raml, wadl, postman

### Formats Supported:

|Name |Description|
|---	|---	|
|apimatic|The APIMatic format|
|wadl2009|The WADL format|
|swagger10|The Swagger 1.2 format|
|swagger20|The Swagger 2.0 JSON format|
|swaggeryaml|The Swagger 2.0 YAML format|
|apiblueprint|The APIBluePrint format|
|raml|The RAML 0.8 format|
|raml10|The RAML 1.0 format|
|postman10|The Postman 1.0 format|
|postman20|The Postman 2.0 format|
|openapi3json|The OpenAPI 3.0 Json format|
|openapi3yaml|The OpenAPI 3.0 Yaml format|
|wsdl|The WSDL format|

### Usage

Basic usage:
```
    steps:
      # you must check out the repository
      - name: Checkout
        uses: actions/checkout@v2
      - name: APIMATIC Transformer
        uses: apimatic/apimatic-transformer-action@v0.1
        id: transform
        with:
         auth: ${{ secrets.AUTH }}
         inputURL: 'https://petstore.swagger.io/v2/swagger.json'
         exportFormat: 'raml'
     # Use the Transformed API Spec as output from our action (id:transform)
      - name: Get the API Spec URL
        run: echo "${{ steps.transform.outputs.specurl }}"
```

This action requires [actions/checkout@v2](https://github.com/actions/checkout) as a first step.

### Example Workflow

```
name: APITransformer
on: [push]

jobs:
  Test_Transformer:
    runs-on: ubuntu-latest
    name: Testing API Transformer Action
    steps:
      # you must check out the repository
      - name: Checkout
        uses: actions/checkout@v2
        
      - name: APIMATIC Transformer
        uses: apimatic/apimatic-transformer-action@v0.1
        id: raml
        with:
         auth: ${{ secrets.AUTH }}
         inputURL: 'https://petstore.swagger.io/v2/swagger.json'
         exportFormat: 'apimatic'
     # Use the Transformed API Spec as output from our action (id:raml)
      - name: Get the API Spec URL
        run: echo "${{ steps.raml.outputs.specurl }}"
        
      - name: APIMATIC Transformer
        uses: apimatic/apimatic-transformer-action@v0.1
        id: wsdl
        with:
         auth: ${{ secrets.AUTH }}
         inputURL: 'https://petstore.swagger.io/v2/swagger.json'
         exportFormat: 'wsdl'
     # Use the Transformed API Spec as output from our action (id:raml)
      - name: Get the API Spec URL
        run: echo "${{ steps.wsdl.outputs.specurl }}"

```

It is recommended to create an [encrypted secret](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets) for the APIMatic API token (`auth`).

### Inputs

###### The input parameter that is passed in the workflow is the Basic Authorization token, It is highly recommended to store the AUTH token in GitHub Secrets.
###### You can create your Basic Authorization token from this [website](https://www.blitter.se/utils/basic-authentication-header-generator/)
###### It will generate a string like this for you: Authorization: Basic cmFuZG9tQGdtYWlsLmNvbTpyYW5kb20=
###### Make sure to add the complete string Authorization: Basic cmFuZG9tQGdtYWlsLmNvbTpyYW5kb20= in your secret as shown in the image below.

![Add Basic Authorization token as a secret](https://cdn-images-1.medium.com/max/800/1*KGipCwDXL7ZHhU3qBvWhaQ.png "Add Basic Authorization token as a secret")

* `auth`: (**Required**) The API Token which is needed for authorization. Register an [APIMatic](https://www.apimatic.io/account/register) account and purchase a subscription to be authorized with you email and password.
* `inputURL`: (**Required**) API Specification URL where the specification that needs to be transformed is located
* `exportFormat`: (**Required**) Required API Specification format for the list of supported formats mentioned above

###### You can either pass the inputURL and exportFormat as arguments to the action as shown in the workflow or you can just create transform.json file as mentioned below.

###### There are three other inputs that are passed to this action if you create a transform.json file to pass fileUrl, exportFormat and codeGenVersion:
* `fileUrl`
* `exportFormat`
* `codeGenVersion`

###### You need to create a json file named transform.json with API Specification URL specified against fileUrl, Required Format against exportFormat and codeGenVersion as 1.

### Outputs

* `specurl`: URL of the newly generated API Specification with the required format passed through the arugment exportFormat

###### Note: The output is the API Specification URL which can be used to download the transformed API specification in the required format but this URL only works with authorization therefore user need to login to APIMATIC and then launch this URL

### Feature requests and bug reports

Please file feature requests and bug reports as [github issues](https://github.com/mujjazi/apimatic-transformer-action/issues).

### License

See [LICENSE](LICENSE)
