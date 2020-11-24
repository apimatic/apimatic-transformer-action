#cd Transformations
uname=$(date +'%m-%d-%Y'+"%H:%M")

user_auth=$1
file=0

FILE=transform.json
if [ -f "$FILE" ]; then
    echo "$FILE exists."
    file=1
else 
    echo "$FILE does not exist."
    file=-1
fi


if [[ $file -gt 0 ]]
then
  transformedfile=$(curl -X POST \
  --url 'https://staging.apimatic.io/api/transformations' \
  -H "$user_auth" \
  -H 'Accept: application/json'\
  -H 'content-type: application/vnd.apimatic.urlTransformDto.v1+json' \
  --data @transform.json | jq '.generatedFile' | sed -e 's/^"//' -e 's/"$//')
else
  transformedfile=$(curl -X POST \
  --url 'https://staging.apimatic.io/api/transformations' \
  -H "$user_auth" \
  -H 'Accept: application/json'\
  -H 'content-type: application/vnd.apimatic.urlTransformDto.v1+json' \
  -d '{
  "fileUrl": "https://petstore.swagger.io/v2/swagger.json",
  "exportFormat": "raml",
  "codeGenVersion": 1
  }' 
  | jq '.generatedFile' | 
  sed -e 's/^"//' -e 's/"$//')
fi

echo $transformedfile
download_path1="https://staging.apimatic.io/${transformedfile}"
echo $download_path1

echo "::set-output name=specurl::$download_path1"







