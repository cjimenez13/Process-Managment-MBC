using System;
using System.Net.Http;


namespace BeyondThemes.BeyondAdmin.Providers
{
    interface IProvider
    {
        HttpClient _Client { get; set; }
    }
}
