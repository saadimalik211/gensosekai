from active_conts import list_active_containers
from inactive_conts import list_inactive_containers
from inactive_vols import list_unassociated_volumes

def main_menu():
    while True:
        print("\nMENU:")
        print("1. List active docker containers and their associated volumes.")
        print("2. List inactive docker containers and their associated volumes.")
        print("3. List volumes that are not associated with a container.")
        print("4. Quit")

        choice = input("Please select an option: ")

        if choice == '1':
            list_active_containers()
        elif choice == '2':
            list_inactive_containers()
        elif choice == '3':
            list_unassociated_volumes()
        elif choice == '4':
            print("Exiting.")
            break
        else:
            print("Invalid option.")

if __name__ == "__main__":
    main_menu()

