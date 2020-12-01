#Arguments
user_auth=$1
input=$2
export=$3

echo $user_auth
echo $input
echo $export

#Trimmed Arguments
trimmed_auth=$(echo "$user_auth" | xargs) 
trimmed_input=$(echo "$input" | xargs)
trimmed_auth=$(echo "$export" | xargs)

echo $trimmed_auth
echo $trimmed_input
echo $trimmed_export

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
  -H "$user_auth" \
  -H 'Accept: application/json'\
  -H 'content-type: application/vnd.apimatic.urlTransformDto.v1+json' \
  --data @transform.json | jq '.generatedFile' | sed -e 's/^"//' -e 's/"$//')
else
  transformedfile=$(curl -X POST \
  --url 'https://www.apimatic.io/api/transformations' \
  -H "$user_auth" \
  -H 'Accept: application/json'\
  -H 'content-type: application/vnd.apimatic.urlTransformDto.v1+json' \
  --data '{
  "fileUrl": "'"${input}"'",
  "exportFormat": "'"${export}"'",
  "codeGenVersion": 1
  }' | jq '.generatedFile' | sed -e 's/^"//' -e 's/"$//')
fi

download_path1="https://www.apimatic.io${transformedfile}"

echo "::set-output name=specurl::$download_path1"







