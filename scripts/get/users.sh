indent() {
	sed 's/^/\t/'
}

echo -e "\nGROUPS:"
awk -F':' '{print $1}' /etc/group | indent

echo -e "\nUSERS:"
awk -F':' '{print $1}' /etc/passwd | indent

