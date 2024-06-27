defmodule Defdo.MyApp.MyMvno.Actor do
  use Ash.Resource,
    authorizers: [Ash.Policy.Authorizer],
    data_layer: AshPostgres.DataLayer,
    domain: Defdo.MyApp.Domain.MyMvno,
    extensions: [AshJsonApi.Resource]

  alias Defdo.MyApp.MyMvno.Resource.Tenant
  alias Defdo.MyApp.MyMvno.Resource.Enums

  postgres do
    table "actor_apis"
    repo MyApp.Repo
    migrate? true
  end

  json_api do
    type "actor"
  end

  policies do
    policy always() do
      authorize_if always()
    end
  end

  multitenancy do
    strategy :attribute
    attribute :tenant_id
  end

  identities do
    identity :unique_actor, [:code, :app_type, :client_id, :tenant_id], message: "Actor already exist"
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      accept [:name, :type, :auth_method, :code, :app_type, :allowed_domains, :client_id]
    end

    read :by_client_id do
      argument :client_id, :string

      filter expr(client_id == ^arg(:client_id))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :type, :atom do
      constraints [one_of: [:end_user, :mvno]]
      allow_nil? false
    end

    attribute :name, :string, public?: true

    attribute :auth_method, :atom do
      constraints [one_of: [:oauth2_code_pkce, :client_credentials]]
      allow_nil? false
    end

    attribute :code, :string, public?: true
    attribute :mvno_profile_id, :integer, public?: true

    attribute :app_type, :atom do
      constraints [one_of: [:api, :web, :spa, :mobile]]
      allow_nil? false
      public? true
    end

    attribute :allowed_domains, {:array, :string}
    attribute :client_id, :string do
      allow_nil? false
    end

    create_timestamp :inserted_at, public?: true
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :tenant, Tenant do
      destination_attribute :tenant_id
      allow_nil? false
    end
  end

  validations do
    validate fn changeset, _context ->
      case {Ash.Changeset.get_attribute(changeset, :type),
            Ash.Changeset.get_attribute(changeset, :auth_method)} do
        {:end_user, :oauth2_code_pkce} -> :ok
        {:mvno, :client_credentials} -> :ok
        _ -> {:error, "Invalid actor type and auth method combination"}
      end
    end

    validate fn changeset, _context ->
      auth_method = Ash.Changeset.get_attribute(changeset, :auth_method)
      code = Ash.Changeset.get_attribute(changeset, :code)
      cond do
        auth_method == :client_credentials && not is_nil(code) ->
          :ok
        auth_method == :oauth2_code_pkce && is_nil(code) ->
          :ok
        true ->
          {:error, "Code is required for client_credential method, and must be not given for oauth2_code_pkce method"}
      end
    end

    validate fn changeset, _context ->
      auth_method = Ash.Changeset.get_attribute(changeset, :auth_method)
      app_type = Ash.Changeset.get_attribute(changeset, :app_type)
      cond do
        auth_method == :client_credentials && app_type == :api ->
          :ok
        auth_method == :oauth2_code_pkce && app_type in [:web, :spa, :mobile] ->
          :ok
        true ->
          {:error, "app_type for auth_method must be api and for oauth2_code_pkce should be web, spa or mobile"}
      end
    end

    validate fn changeset, _context ->
      app_type = Ash.Changeset.get_attribute(changeset, :app_type)
      allowed_domains = Ash.Changeset.get_attribute(changeset, :allowed_domains)
      if app_type != :mobile && (not is_nil(allowed_domains) or allowed_domains == []) do
        :ok
      else
        {:error, "allowed_domains is required for you app type: #{app_type}"}
      end
    end
  end
end
