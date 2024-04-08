
ACCOUNT_ID="$(aws sts get-caller-identity | jq -r '.Account')"
resp=$(aws sts assume-role \
        --role-arn "arn:aws:iam::${ACCOUNT_ID}:role/AdminEC2" --role-session-name "$(uuidgen)")

# parse the result json
ACCESS_KEY=`echo $resp | jq -r .Credentials.AccessKeyId`
SECRET_KEY=`echo $resp | jq -r .Credentials.SecretAccessKey`
SESSION_TOKEN=`echo $resp | jq -r .Credentials.SessionToken`
# # show the result with "export" style
#
echo -ne "\nThis is n${ROLE_NAME} temporary credential.\nPaste them in your shell! \n\nexport AWS_DEFAULT_REGION=\"${AWS_DEFAULT_REGION}\"\nexport ACCOUNT_ID=\"${ACCOUNT_ID}\"\nexport AWS_ACCESS_KEY_ID=\"${ACCESS_KEY}\"\nexport AWS_SECRET_ACCESS_KEY=\"${SECRET_KEY}\";\nexport AWS_SESSION_TOKEN=\"${SESSION_TOKEN}\"\n\n"

echo ""

echo -ne ":aws-access-key-id \"${ACCESS_KEY}\"\n:aws-secret-access-key \"${SECRET_KEY}\"\n:aws-session-token \"${SESSION_TOKEN}\"\n:region \"${AWS_DEFAULT_REGION}\"\n:account-id \"${ACCOUNT_ID}\"\n\n"
#
