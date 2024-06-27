defmodule Defdo.MyApp.MyMvno.Resource.Tenant do
  use Ash.Resource,
    domain: Defdo.MyApp.Domain.MyMvno,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJsonApi.Resource]

  alias Defdo.MyApp.MyMvno.Resource.Enums
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
    defaults [:read]

    
  end

  attributes do
    uuid_primary_key :tenant_id
    attribute :name, :string, public?: true
    attribute :region, :string, public?: true
    attribute :environment, :string, public?: true
    attribute :code, :string, public?: true
    attribute :logo, :string, public?: true
    attribute :theme, :string, public?: true

    attribute :tier, Enums.Tier, public?: true
    attribute :domain, :string, public?: true
    attribute :custom_domain, :string, public?: true
    attribute :is_active, :boolean, public?: true
    attribute :is_deleted, :boolean, public?: true

    create_timestamp :inserted_at, public?: true
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :tenant, Resource.Tenant do
      destination_attribute :tenant_id
    end
  end

  def to_resource(%_{} = ecto_tenant) do
    tenant = Map.from_struct(ecto_tenant)
    struct(__MODULE__, tenant)
  end

  def to_ash_tenant(ecto_tenant) do
    tenant = to_resource(ecto_tenant)
    Ash.ToTenant.to_tenant(tenant, __MODULE__)
  end
  # %Defdo.Tenant.Schema.Profile{} -> %Defdo.MyApp.MyMvno.Resource.Tenant{}

  # assign(:tenant, %Ecto.Tenant{})

  # conn.assigns.tenant = to_tenant() -> id
  # conn.assigns.private.ash.tenant = to_tenant() -> id

  defimpl Ash.ToTenant do
    def to_tenant(%{tenant_id: id}, resource) do
      if Ash.Resource.Info.data_layer(resource) == AshPostgres.DataLayer do
        id
      end
    end
  end

  defimpl Ash.ToTenant, for: Defdo.Tenant.Schema.Profile do
    def to_tenant(%{tenant_id: tenant_id}, resource) do
      tenant_id
    end
  end
end
