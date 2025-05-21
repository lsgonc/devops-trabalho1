using System;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Devops.Trabalho1.Data;
using Volo.Abp.DependencyInjection;

namespace Devops.Trabalho1.EntityFrameworkCore;

public class EntityFrameworkCoreTrabalho1DbSchemaMigrator
    : ITrabalho1DbSchemaMigrator, ITransientDependency
{
    private readonly IServiceProvider _serviceProvider;

    public EntityFrameworkCoreTrabalho1DbSchemaMigrator(IServiceProvider serviceProvider)
    {
        _serviceProvider = serviceProvider;
    }

    public async Task MigrateAsync()
    {
        /* We intentionally resolving the Trabalho1DbContext
         * from IServiceProvider (instead of directly injecting it)
         * to properly get the connection string of the current tenant in the
         * current scope.
         */

        await _serviceProvider
            .GetRequiredService<Trabalho1DbContext>()
            .Database
            .MigrateAsync();
    }
}
