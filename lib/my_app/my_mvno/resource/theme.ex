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
    migrate? false
  end

  json_api do
    type "theme"
  end

  policies do
    policy action_type(:read) do
      authorize_if relates_to_actor_via(:owner)
    end
  end

  # multitenancy do
  #   strategy :attribute
  #   attribute :tenant_id
  # end

  actions do
    defaults [:read]

    read :theme do
      # get? true
      # argument :code, :string, allow_nil?: true
      # filter expr(code == ^arg(:code))

      # prepare fn query, c ->
      #   IO.inspect(c)
      #   # Ash.Query.after_action(query, fn _query, results ->
      #   #   if YourApi.can?(__MODULE__, :read, data: results) do
      #   #     {:ok, results}
      #   #   else
      #   #     {:error, Ash.Error.Forbidden.exception()}
      #   #   end
      #   # end)
      #   query
      # end

      # IO.inspect "hello"
      # Defdo.Tenant.inject_tenant("6fa040bf-499a-4dae-ad71-cc9f66fb75b1")
      # IO.inspect(Defdo.Tenant.tenant_id())
      # filter expr(tenant_id = "6fa040bf-499a-4dae-ad71-cc9f66fb75b1")
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string, public?: true
    attribute :code, :string, public?: true

    # attribute :tenant_id, :uuid
    create_timestamp :inserted_at, public?: true
    update_timestamp :updated_at
  end

  relationships do
    # belongs_to :tenant, Tenant do
    #   destination_attribute :tenant_id
    # end

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
