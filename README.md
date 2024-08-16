# Omniauth::Layers

This is the Layers strategy for authenticating to Layers with OmniAuth. To use it you'll need to create an account over at [Layers](https://layers.education/).

## Usage

	use OmniAuth::Builder do
	  provider :layers, ENV['LAYERS_ID']
	end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
