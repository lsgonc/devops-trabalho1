using Volo.Abp.Modularity;

namespace Devops.Trabalho1;

/* Inherit from this class for your domain layer tests. */
public abstract class Trabalho1DomainTestBase<TStartupModule> : Trabalho1TestBase<TStartupModule>
    where TStartupModule : IAbpModule
{

}
