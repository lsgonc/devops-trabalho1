using Volo.Abp.PermissionManagement;
using Volo.Abp.SettingManagement;
using Volo.Abp.Account;
using Volo.Abp.Identity;
using Volo.Abp.AutoMapper;
using Volo.Abp.FeatureManagement;
using Volo.Abp.Modularity;
using Volo.Abp.AuditLogging;
using Volo.Abp.Gdpr;
using Volo.Abp.LanguageManagement;
using Volo.Abp.OpenIddict;
using Volo.Abp.TextTemplateManagement;
using Volo.Saas.Host;

namespace Devops.Trabalho1;

[DependsOn(
    typeof(Trabalho1DomainModule),
    typeof(Trabalho1ApplicationContractsModule),
    typeof(AbpPermissionManagementApplicationModule),
    typeof(AbpFeatureManagementApplicationModule),
    typeof(AbpIdentityApplicationModule),
    typeof(AbpAccountPublicApplicationModule),
    typeof(AbpAccountAdminApplicationModule),
    typeof(SaasHostApplicationModule),
    typeof(AbpAuditLoggingApplicationModule),
    typeof(TextTemplateManagementApplicationModule),
    typeof(AbpOpenIddictProApplicationModule),
    typeof(LanguageManagementApplicationModule),
    typeof(AbpGdprApplicationModule),
    typeof(AbpSettingManagementApplicationModule)
    )]
public class Trabalho1ApplicationModule : AbpModule
{
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        Configure<AbpAutoMapperOptions>(options =>
        {
            options.AddMaps<Trabalho1ApplicationModule>();
        });
    }
}
