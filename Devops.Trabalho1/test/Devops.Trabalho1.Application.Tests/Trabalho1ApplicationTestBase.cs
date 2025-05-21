using Volo.Abp.Modularity;

namespace Devops.Trabalho1;

public abstract class Trabalho1ApplicationTestBase<TStartupModule> : Trabalho1TestBase<TStartupModule>
    where TStartupModule : IAbpModule
{

}
