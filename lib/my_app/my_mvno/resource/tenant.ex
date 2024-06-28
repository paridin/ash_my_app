defmodule Defdo.MyApp.MyMvno.Resource.Tenant do
  use Ash.Resource,
    domain: Defdo.MyApp.Domain.MyMvno,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJsonApi.Resource]

  alias Defdo.MyApp.MyMvno.Resource

  postgres do
    table "tenant_profiles"
    repo MyApp.Repo
    migrate? true
  end

  json_api do
    type "theme"
  end

  actions do
    defaults [:read, :create]
    default_accept :*
  end

  attributes do
    uuid_primary_key :tenant_id
    attribute :name, :string, public?: true

    create_timestamp :inserted_at, public?: true
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :tenant, Resource.Tenant do
      destination_attribute :tenant_id
    end
  end

  defimpl Ash.ToTenant do
    def to_tenant(%{tenant_id: id}, resource) do
      if Ash.Resource.Info.data_layer(resource) == AshPostgres.DataLayer do
        id
      end
    end
  end
end
