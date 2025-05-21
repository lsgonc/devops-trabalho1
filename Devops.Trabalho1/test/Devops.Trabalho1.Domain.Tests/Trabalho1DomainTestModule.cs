using Volo.Abp.Modularity;

namespace Devops.Trabalho1;

[DependsOn(
    typeof(Trabalho1DomainModule),
    typeof(Trabalho1TestBaseModule)
)]
public class Trabalho1DomainTestModule : AbpModule
{

}
