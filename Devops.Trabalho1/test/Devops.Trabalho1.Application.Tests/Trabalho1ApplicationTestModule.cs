using Volo.Abp.Modularity;

namespace Devops.Trabalho1;

[DependsOn(
    typeof(Trabalho1ApplicationModule),
    typeof(Trabalho1DomainTestModule)
)]
public class Trabalho1ApplicationTestModule : AbpModule
{

}
