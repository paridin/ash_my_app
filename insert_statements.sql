INSERT INTO "tenant_profiles"("tenant_id","name","region","environment","code","theme","tier","domain","custom_domain","is_active","is_deleted","inserted_at","updated_at")
VALUES
(E'6fa040bf-499a-4dae-ad71-cc9f66fb75b1',E'defdo - core',E'us-east-1',E'production',E'defdo',E'defdo_dark',E'enterprise',E'h.defdo.ninja',E'localhost',TRUE,FALSE,E'2024-04-15 21:10:19+00',E'2024-04-15 21:10:19+00');


INSERT INTO "actor_apis"("id","type","name","auth_method","code","mvno_profile_id","app_type","allowed_domains","client_id","inserted_at","updated_at","tenant_id")
VALUES
(E'67cf0d5b-0008-43f1-b22f-00f3f37ed4bd',E'mvno',E'api json example',E'client_credentials',E'defdo',4,E'api',E'{https://localhost:4003}',E'3a105696-f440-4322-af76-56b0d025f0fd',E'2024-06-27 02:19:20.927922',E'2024-06-27 02:19:20.927922',E'6fa040bf-499a-4dae-ad71-cc9f66fb75b1');


INSERT INTO "public"."mvno_packages"("name","mvno_id","inserted_at","updated_at","call_center","captive","landing","ivr","sales","third_party","treat_as_gift","product_type","package_type","package_image","can_purchase","can_topup","benefits","period","validity","category","service_type")
VALUES
(E'Coder 128',4,E'2021-06-04 22:36:13+00',E'2021-06-04 22:36:13+00',TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,E'mobility',E'multi_no_fiff',NULL,TRUE,TRUE,NULL,E'month',NULL,NULL,E'mbb'),
(E'Coder 256',4,E'2021-06-04 22:36:13+00',E'2021-06-04 22:36:13+00',TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,E'mobility',E'multi_no_fiff',NULL,TRUE,TRUE,NULL,E'month',NULL,NULL,E'mbb'),
(E'Coder 512',4,E'2021-06-04 22:36:13+00',E'2021-06-04 22:36:13+00',TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,E'mobility',E'multi_no_fiff',NULL,TRUE,TRUE,NULL,E'month',NULL,NULL,E'mbb'),
(E'Ninja 5GB Anual FFM',4,E'2022-05-21 00:00:00+00',E'2022-05-21 00:00:00+00',TRUE,FALSE,TRUE,TRUE,TRUE,TRUE,FALSE,E'mobility',E'basic_package',NULL,TRUE,TRUE,NULL,E'month',NULL,NULL,E'mbb'),
(E'Ninja 40GB Anual FFM',4,E'2022-05-21 00:00:00+00',E'2022-05-21 00:00:00+00',FALSE,FALSE,TRUE,FALSE,TRUE,TRUE,FALSE,E'mobility',E'basic_package',NULL,TRUE,TRUE,NULL,E'month',NULL,NULL,E'mbb'),
(E'Ninja 40GB+ Anual FFM',4,E'2022-05-21 00:00:00+00',E'2022-05-21 00:00:00+00',FALSE,FALSE,TRUE,FALSE,TRUE,TRUE,FALSE,E'mobility',E'basic_package',NULL,TRUE,TRUE,NULL,E'month',NULL,NULL,E'mbb'),
(E'Coder Foo',4,E'2022-08-03 22:46:06+00',E'2022-08-03 22:46:06+00',TRUE,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,E'mobility',E'multi',NULL,TRUE,TRUE,NULL,E'month',NULL,NULL,E'mbb'),
(E'Coder 256+',4,E'2022-08-09 16:42:00+00',E'2022-08-09 16:42:00+00',TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,E'mobility',E'multi',NULL,TRUE,TRUE,NULL,E'month',NULL,NULL,E'mbb');