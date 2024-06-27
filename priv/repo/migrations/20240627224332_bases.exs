defmodule MyApp.Repo.Migrations.Bases do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:tenant_profiles, primary_key: false) do
      add :tenant_id,
          references(:tenant_profiles,
            column: :tenant_id,
            name: "tenant_profiles_tenant_id_fkey",
            type: :uuid,
            prefix: "public"
          ),
          default: fragment("gen_random_uuid()"),
          primary_key: true,
          null: false

      add :name, :text
      add :region, :text
      add :environment, :text
      add :code, :text
      add :logo, :text
      add :theme, :text
      add :tier, :text
      add :domain, :text
      add :custom_domain, :text
      add :is_active, :boolean
      add :is_deleted, :boolean

      add :inserted_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")
    end

    create table(:mvno_packages, primary_key: false) do
      add :id, :bigserial, null: false, primary_key: true
      add :name, :text
      add :mvno_id, :bigint
      add :landing, :boolean
      add :call_center, :boolean
      add :ivr, :boolean
      add :sales, :boolean
      add :captive, :boolean
      add :third_party, :boolean
      add :treat_as_gift, :boolean
      add :product_type, :text
      add :package_type, :text
      add :package_image, :text
      add :can_purchase, :boolean
      add :can_topup, :boolean
      add :period, :text
      add :category, :text
      add :benefits, {:array, :text}
      add :service_type, :text
      add :validity, :bigint

      add :inserted_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")
    end

    create table(:actor_apis, primary_key: false) do
      add :id, :uuid, null: false, default: fragment("gen_random_uuid()"), primary_key: true
      add :type, :text, null: false
      add :name, :text
      add :auth_method, :text, null: false
      add :code, :text
      add :mvno_profile_id, :integer
    end

    # alter table(:mvno_packages) do
    #   modify :mvno_id,
    #          references(:actor_apis,
    #            column: :mvno_profile_id,
    #            name: "mvno_packages_mvno_id_fkey",
    #            type: :bigint,
    #            prefix: "public"
    #          )
    # end

    alter table(:actor_apis) do
      add :app_type, :text, null: false
      add :allowed_domains, {:array, :text}
      add :client_id, :text, null: false

      add :inserted_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :tenant_id,
          references(:tenant_profiles,
            column: :tenant_id,
            name: "actor_apis_tenant_id_fkey",
            type: :uuid,
            prefix: "public"
          ),
          null: false
    end

    create unique_index(:actor_apis, [:tenant_id, :code, :app_type, :client_id, :tenant_id],
             name: "actor_apis_unique_actor_index"
           )

    create index(:actor_apis, [:tenant_id])
  end

  def down do
    drop_if_exists unique_index(
                     :actor_apis,
                     [:tenant_id, :code, :app_type, :client_id, :tenant_id],
                     name: "actor_apis_unique_actor_index"
                   )

    drop constraint(:actor_apis, "actor_apis_tenant_id_fkey")

    alter table(:actor_apis) do
      remove :tenant_id
      remove :updated_at
      remove :inserted_at
      remove :client_id
      remove :allowed_domains
      remove :app_type
    end

    drop constraint(:mvno_packages, "mvno_packages_mvno_id_fkey")

    # alter table(:mvno_packages) do
    #   modify :mvno_id, :bigint
    # end

    drop table(:actor_apis)

    drop table(:mvno_packages)

    drop constraint(:tenant_profiles, "tenant_profiles_tenant_id_fkey")

    drop table(:tenant_profiles)
  end
end
