module.exports = {
  networks: {
    development: {
     host: "10.0.2.2",
     port: 7545,
     network_id: "*",
     private_keys: ["0xf5dc35842b95c7df562c10e804bc109e91cabff2f36f294ef1f9e8945e1d01e6"]
    },
    dashboard: {
    }
  },
  compilers: {
    solc: {
      version: "0.8.13",
    }
  },
  db: {
    enabled: false,
    host: "127.0.0.1",
  }
};
