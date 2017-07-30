# if this were a real app, these api keys would only be stored in evironment variables
# but since this is just a sandbox app, we don't really need to worry about safety

Rails.configuration.stripe = {
  :publishable_key => ENV["STRIPE_PUBLISHABLE_KEY"] || 'pk_test_Ew79wA08Ce8Iwl48bsEamM2n',
  :secret_key      => ENV["STRIPE_SECRET_KEY"] || 'sk_test_I6d4kidph7l79EBqqrnWtEBO'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]