defmodule Defdo.MyApp.MyMvno.Resource.Theme do
  use Ash.Resource,
    authorizers: [Ash.Policy.Authorizer],
    data_layer: AshPostgres.DataLayer,
    domain: Defdo.MyApp.Domain.MyMvno,
    extensions: [AshJsonApi.Resource]

  alias Defdo.MyApp.MyMvno.Resource.Tenant
  alias Defdo.MyApp.MyMvno.Actor

  postgres do
    table "defdo_themes"
    repo MyApp.Repo
  end

  json_api do
    type "theme"
  end

  policies do
    policy action_type(:read) do
      authorize_if relates_to_actor_via(:owner)
    end
  end

  multitenancy do
    strategy :attribute
    attribute :tenant_id
  end

  actions do
    defaults [:read, :create]
    default_accept :*
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string, public?: true
    attribute :code, :string, public?: true

    create_timestamp :inserted_at, public?: true
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :tenant, Tenant do
      destination_attribute :tenant_id
    end

    belongs_to :owner, Actor do
      primary_key? false
      attribute_public? false
      public? false
      define_attribute? false

      attribute_type :string
      destination_attribute :code
      source_attribute :code
    end
  end
end
