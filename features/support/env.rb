require 'buschtelefon'
require 'factory_bot'

module DefaultStepHelper
  def tattlers
    @tattlers ||= {}
  end
end

World(FactoryBot::Syntax::Methods, DefaultStepHelper) do
  include Buschtelefon
  Object.new
end