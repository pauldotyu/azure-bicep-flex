param name_prefix string
param password string {
  secure: true
}
param acceptMarketingEmails bool = false
param email string = ''
param tags object = {}

var name = '${name_prefix}${uniqueString(resourceGroup().id)}'

resource sg 'Sendgrid.Email/accounts@2015-01-01' = {
  location: resourceGroup().location
  name: name
  plan:{
    name: 'free'
    publisher: 'Sendgrid'
    product: 'sendgrid_azure'
    promotionCode: ''
  }
  properties: {
    password: password
    acceptMarketingEmails: acceptMarketingEmails
    email: email
  }
  tags: tags
}