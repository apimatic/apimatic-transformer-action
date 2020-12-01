#Arguments
user_auth=$1
input=$2
export=$3


auth1="$(echo -e "${user_auth}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
input1="$(echo -e "${input}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
export1="$(echo -e "${export}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"



file=0
FILE=transform.json

if [ -f "$FILE" ]; then
    file=1
else 
    file=-1
fi


if [[ $file -gt 0 ]]
then
  transformedfile=$(curl -X POST \
  --url 'https://www.apimatic.io/api/transformations' \
  -H "$auth1" \
  -H 'Accept: application/json'\
  -H 'content-type: application/vnd.apimatic.urlTransformDto.v1+json' \
  --data @transform.json | jq '.generatedFile' | sed -e 's/^"//' -e 's/"$//')
else
  transformedfile=$(curl -X POST \
  --url 'https://www.apimatic.io/api/transformations' \
  -H "$auth1" \
  -H 'Accept: application/json'\
  -H 'content-type: application/vnd.apimatic.urlTransformDto.v1+json' \
  --data '{
  "fileUrl": "'"${input1}"'",
  "exportFormat": "'"${export1}"'",
  "codeGenVersion": 1
  }' | jq '.generatedFile' | sed -e 's/^"//' -e 's/"$//')
fi

download_path2="You have an error in your authorization token or InputURL/Export Format!"

if [[ $transformedfile == *Invalid* ]] 
then
  echo "You have an error in your authorization token or InputURL/Export Format!"
  echo "::set-output name=specurl::$download_path1"  
else
  download_path1="https://www.apimatic.io${transformedfile}"
  echo "::set-output name=specurl::$download_path1"
fi








