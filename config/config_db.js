const config = {
    host: 'localhost',
    user: 'Developer',
    password: 'PerroCafe',
    dateStrings: true,
    database: 'e_commerce',
    typeCast: function castField(field, useDefaultTypeCasting) {
      if ((field.type === "BIT") && (field.length === 1)) {
  
        var bytes = field.buffer();
  
        return (bytes[0] === 1);
  
      }
  
      return (useDefaultTypeCasting());
  
    }
}

module.exports = config;