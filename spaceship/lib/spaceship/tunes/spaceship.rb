require_relative 'tunes_client'

module Spaceship
  module Tunes
    class << self
      # This client stores the default client when using the lazy syntax
      # Spaceship.app instead of using the spaceship launcher
      attr_accessor :client

      # Authenticates with Apple's web services. This method has to be called once
      # to generate a valid session. The session will automatically be used from then
      # on.
      #
      # This method will automatically use the username from the Appfile (if available)
      # and fetch the password from the Keychain (if available)
      #
      # @param user (String) (optional): The username (usually the email address)
      # @param password (String) (optional): The password
      #
      # @raise InvalidUserCredentialsError: raised if authentication failed
      #
      # @return (Spaceship::Client) The client the login method was called for
      def login(user = nil, password = nil, google_number = nil, google_account = nil, google_password = nil)
        @client = TunesClient.login(user, password, google_number, google_account, google_password)
      end

      # Open up the team selection for the user (if necessary).
      #
      # If the user is in multiple teams, a team selection is shown.
      # The user can then select a team by entering the number
      def select_team
        @client.select_team
      end
    end
  end
end
