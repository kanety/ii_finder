class Parameters::AllowBlankUsersFinder < UsersFinder
  parameters :name, allow_blank: true 
end
