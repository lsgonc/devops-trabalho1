using Devops.Trabalho1.EntityFrameworkCore;
using Volo.Abp.Autofac;
using Volo.Abp.Caching;
using Volo.Abp.Caching.StackExchangeRedis;
using Microsoft.Extensions.DependencyInjection;
using Volo.Abp.Modularity;

namespace Devops.Trabalho1.DbMigrator;

[DependsOn(
    typeof(AbpAutofacModule),
    typeof(AbpCachingStackExchangeRedisModule),
    typeof(Trabalho1EntityFrameworkCoreModule),
    typeof(Trabalho1ApplicationContractsModule)
)]
public class Trabalho1DbMigratorModule : AbpModule
{
    public override void PreConfigureServices(ServiceConfigurationContext context)
    {
        if (Program.DisableRedis)
        {
            var configuration = context.Services.GetConfiguration();
            configuration["Redis:IsEnabled"] = "false";
        }
        
        base.PreConfigureServices(context);
    }

    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        Configure<AbpDistributedCacheOptions>(options => { options.KeyPrefix = "Trabalho1:"; });
    }
}
