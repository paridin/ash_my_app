defmodule Defdo.MyApp.MyMvno.Resource.Enums.Period do
  use Ash.Type.Enum, values: [:minute, :hour, :day, :month, :year]
end

defmodule Defdo.MyApp.MyMvno.Resource.Enums.ServiceType do
  use Ash.Type.Enum, values: [:hbb, :mbb, :mifi, :iot]
end

defmodule Defdo.MyApp.MyMvno.Resource.Enums.Tier do
  use Ash.Type.Enum, values: [:starter, :"open-source", :startup, :enterprise, :iot]
end
