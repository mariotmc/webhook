**Send an event**
`curl -u username:password "http://localhost:3000/webhook/subscriptions?receiver_url=http://localhost:3000/webhook/endpoints&topic=<topic>&customer_id=<customer_id>"`

**Credentials for request auth**
`rails credentials:edit`
