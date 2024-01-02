#!/bin/sh

cat > /run/secrets/output<<EOF
services: mysql: {
  address: "${address}"
  default: true
  ports: "3306:${port}"
  data: {
    proto: "${proto}"
    dbName: "${dbName}"
  }
}

secrets: admin: {
  type: "basic"
  data: {
    username: "${adminUsername}"
    password: "${adminPassword}"
  }
}
EOF

if [ "${username}" != "" ]; then
cat >> /run/secrets/output<<EOF
services: mysql: secrets: ["admin", "user"]
secrets: user: {
  type: "basic"
  data: {
    username: "${username}"
    password: "${password}"
  }
}
EOF
exit 0
else
cat >> /run/secrets/output<<EOF
services: mysql: secrets: ["admin"]
EOF
fi
