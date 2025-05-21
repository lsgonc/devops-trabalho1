using System.Threading.Tasks;
using Volo.Abp.DependencyInjection;

namespace Devops.Trabalho1.Data;

/* This is used if database provider does't define
 * ITrabalho1DbSchemaMigrator implementation.
 */
public class NullTrabalho1DbSchemaMigrator : ITrabalho1DbSchemaMigrator, ITransientDependency
{
    public Task MigrateAsync()
    {
        return Task.CompletedTask;
    }
}
