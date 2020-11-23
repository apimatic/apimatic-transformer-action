#cd Transformations
uname=$(date +'%m-%d-%Y'+"%H:%M")

somevar1=$(curl -X POST \
  --url 'https://staging.apimatic.io/api/transformations' \
  --header $1 \
  -H 'Accept: application/json'\
  -H 'content-type: application/vnd.apimatic.urlTransformDto.v1+json' \
  --data @transform.json | jq '.generatedFile' | sed -e 's/^"//' -e 's/"$//')

echo $somevar1
download_path1="https://staging.apimatic.io/${somevar1}"
echo $download_path1
name1=petapi_$uname.json
#curl --location --header ${INPUT_AUTH_ID} --remote-header-name -o $name1 $download_path1







