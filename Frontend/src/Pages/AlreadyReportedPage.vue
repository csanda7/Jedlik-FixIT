<template>
  <div :class="['reported-bugs-container', { 'dark-mode': isDarkMode }, 'container', 'mt-5']">
    <div :class="[ 'card', 'shadow-sm', { 'dark-mode': isDarkMode }]">
      <div :class="['card-header', { 'dark-mode': isDarkMode }, 'd-flex', 'justify-content-between', 'align-items-center']">
        <h2 class="mb-0 me-3 h2">BEJELENTETT HIBÁK</h2>
        <div class="user-actions d-flex">
          <input type="text" class="form-control search-input me-3" placeholder="Keresés..." v-model="searchTerm" />
          <button class="btn btn-secondary" type="button" @click="toggleFilterVisibility">
            <i class="bi bi-funnel-fill"></i>
          </button>
        </div>
      </div>
      <!-- Updated filters section with responsive design -->
      <div v-if="showFilters" class="filters-container">
        <div class="filters-wrapper">
          <!-- Priority Filter -->
          <div class="filter-dropdown">
            <button class="btn btn-secondary dropdown-toggle" id="FilterDropDown" type="button" data-bs-toggle="dropdown"
              aria-expanded="false">
              Prioritás
            </button>
            <ul class="dropdown-menu">
              <li v-for="priority in uniquePriorities" :key="priority" class="px-3 py-1">
                <label>
                  <input class="form-check-input" type="checkbox" :value="priority" v-model="selectedPriorities" /> {{ priority }}
                </label>
              </li>
            </ul>
          </div>

          <!-- Label Filter -->
          <div class="filter-dropdown">
            <button class="btn btn-secondary dropdown-toggle" id="FilterDropDown" type="button" data-bs-toggle="dropdown"
              aria-expanded="false">
              Címke
            </button>
            <ul class="dropdown-menu">
              <li v-for="label in uniqueLabels" :key="label" class="px-3 py-1">
                <label>
                  <input class="form-check-input" type="checkbox" :value="label" v-model="selectedLabels" /> {{ label }}
                </label>
              </li>
            </ul>
          </div>

          <!-- Status Filter -->
          <div class="filter-dropdown">
            <button class="btn btn-secondary dropdown-toggle" id="FilterDropDown" type="button" data-bs-toggle="dropdown"
              aria-expanded="false">
              Státusz
            </button>
            <ul class="dropdown-menu">
              <li v-for="status in uniqueStatuses" :key="status" class="px-3 py-1">
                <label>
                  <input class="form-check-input" type="checkbox" :value="status" v-model="selectedStatuses" /> {{ status }}
                </label>
              </li>
            </ul>
          </div>

          <!-- Room Filter -->
          <div class="filter-dropdown">
            <button class="btn btn-secondary dropdown-toggle" id="FilterDropDown" type="button" data-bs-toggle="dropdown"
              aria-expanded="false">
              Terem
            </button>
            <ul class="dropdown-menu">
              <li v-for="room in uniqueRooms" :key="room" class="px-3 py-1">
                <label>
                  <input class="form-check-input" type="checkbox" :value="room" v-model="selectedRooms" /> {{ room }}
                </label>
              </li>
            </ul>
          </div>
        </div>
      </div>


      <div class="card-body p-0">
        <div class="table-responsive">
          <table :class="['table', { 'dark-mode': isDarkMode }, 'table-hover', 'p-4']">
          <thead>
            <tr>
              <th @click="sortBy('name')" style="cursor: pointer;">
                Hiba neve
                <i v-if="sortKey === 'name'"
                  :class="['ms-2', sortOrder === 'asc' ? 'bi bi-arrow-up' : 'bi bi-arrow-down']"></i>
              </th>
              <th @click="sortBy('priority')" style="cursor: pointer;">
                Prioritás
                <i v-if="sortKey === 'priority'"
                  :class="['ms-2', sortOrder === 'asc' ? 'bi bi-arrow-up' : 'bi bi-arrow-down']"></i>
              </th>
              <th class="hide-mobile">Címke</th>
              <th class="hide-mobile">Státusz</th>
              <th class="hide-mobile" @click="sortBy('room')" style="cursor: pointer;">
                Terem
                <i v-if="sortKey === 'room'"
                  :class="['ms-2', sortOrder === 'asc' ? 'bi bi-arrow-up' : 'bi bi-arrow-down']"></i>
              </th>
              <th class="hide-mobile" @click="sortBy('reportedBy')" style="cursor: pointer;">
                Bejelentette
                <i v-if="sortKey === 'reportedBy'"
                  :class="['ms-2', sortOrder === 'asc' ? 'bi bi-arrow-up' : 'bi bi-arrow-down']"></i>
              </th>
              <th class="hide-mobile" @click="sortBy('reportedAt')" style="cursor: pointer;">
                Bejelentés ideje
                <i v-if="sortKey === 'reportedAt'"
                  :class="['ms-2', sortOrder === 'asc' ? 'bi bi-arrow-up' : 'bi bi-arrow-down']"></i>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(bug, index) in filteredBugs" :key="index" @click="openModal(bug)" style="cursor: pointer">
              <td>{{ bug.name }}</td>
              <td>
                <div v-if="bug.priority === 0">Nincs prioritás</div>
                <div v-else class="priority-container">
                  <span :class="['priority-bar', bug.priorityColor]"></span>
                  <span>{{ bug.priority }}</span>
                </div>
              </td>
              <td class="hide-mobile">{{ bug.label }}</td>
              <td class="hide-mobile status-column">
                <span :class="['badge', bug.badgeClass, { 'dark-mode': isDarkMode }]">{{ bug.status }}</span>
              </td>
              <td class="hide-mobile">{{ bug.room }}</td>
              <td class="hide-mobile">{{ bug.reportedBy }}</td>
              <td class="hide-mobile">{{ bug.reportedAt }}</td>
            </tr>
            <tr v-if="filteredBugs.length === 0">
              <td colspan="7" class="text-center">Nincs találat</td>
            </tr>
          </tbody>
        </table>
        </div>
      </div>
    </div>

     <!-- Modal -->
     <div v-if="showModal" class="modal-overlay" @click="closeModal">
      <div class="bg" @click.stop>
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title">{{ selectedBug.name }}</h3>
          </div>
          <div class="modal-body">
            <div class="row">
              <div class="col-md-4">
                <div class="d-flex align-items-center mb-2">
                  <strong>Prioritás: </strong>
                  <div v-if="selectedBug.priority === 0" class="ms-2">Nincs prioritás</div>
                  <div v-else class="priority-container ms-2 my-1">
                    <span :class="['priority-bar', selectedBug.priorityColor]"></span>
                    <span>{{ selectedBug.priority }}</span>
                  </div>
                </div>
                <p><strong>Címke:</strong> {{ selectedBug.label }}</p>
                <div class="d-flex align-items-center mb-2 my-1">
                  <strong>Státusz: </strong>
                  <span :class="['badge', selectedBug.badgeClass, 'ms-2', { 'dark-mode': isDarkMode }]">{{
                    selectedBug.status }}</span>
                </div>
                <p class="my-3"><strong>Terem:</strong> {{ selectedBug.room }}</p>
                <p class="my-3"><strong>Bejelentette:</strong> {{ selectedBug.reportedBy }}</p>
                <p class="my-3"><strong>Bejelentés ideje:</strong> {{ selectedBug.reportedAt }}</p>
                <p v-if="selectedBug.reportedAt !== selectedBug.hibaIdopont" class="my-3"><strong>Hiba időpontja:</strong> {{ selectedBug.hibaIdopont }}</p>
                <p class="my-3" v-if="selectedBug.assignedTo"><strong>Feladatot elvállalta:</strong> {{
                  selectedBug.assignedTo }}</p>
              </div>
              <div class="col-md-4 description">
                <p><strong>Hiba leírása:</strong></p>
                <div class="description-content">{{ selectedBug.description }}</div>
              </div>
              <div class="col-md-4 photo_box">
                <div class="photo-grid">
                  <div v-for="(photo, index) in selectedBug.photos" :key="index" class="photo-item">
                    <img :src="photo" class="image-thumbnail" :alt="'Bug photo ' + index" @click="openPhoto(photo)" />
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="modal-footer">

      <!-- Komment írása -->
  <!--   <button
    type="button"
    class="btn btn-primary mx-1"
    @click="openSecondModal(komment)"
  >
    Komment írása
  </button>  -->


  <!-- Feladat elvállalása -->
  <button
    type="button"
    class="btn btn-primary mx-1"
    v-if="role === 'rendszergazda' && !selectedBug.assignedTo"
    @click="openSecondModal(takeTask)"
  >
    Elvállalom
  </button>

  <!-- Feladat kiosztása -->
  <div v-else-if="role === 'muszakivezeto' && !selectedBug.assignedTo" class="dropdown" style="cursor: pointer;">
    <button
      v-if="selectedUser"
      type="button"
      class="btn btn-primary mx-1 my-2"
      @click="openSecondModal(() => assignTaskTo(selectedUser))"
    >
      Feladat kiosztása
    </button>

    <button
      ref="dropdownButton"
      class="btn btn-primary dropdown-toggle fixed-width my-2"
      type="button"
      data-bs-toggle="dropdown"
      aria-expanded="false"
    >
      {{ selectedUser || 'Feladat kiosztása' }}
    </button>

    <ul class="dropdown-menu fixed-width">
      <li v-for="user in usersWithRoles" :key="user">
        <a class="dropdown-item text-center" @click="selectUser(user)">{{ user }}</a>
      </li>
    </ul>
  </div>

  <!-- Dropdown Menu for Task Status Update -->
  <div v-if="loggedInUser === assignedTo && !['Meghiúsult', 'Kész', 'Bejelentve'].includes(status)">
    <div class="dropdown" style="cursor: pointer;">
      <button
        class="btn btn-primary dropdown-toggle px-4"
        type="button"
        id="statusDropdown"
        data-bs-toggle="dropdown"
        aria-expanded="false"
      >
        Állapot frissítése
      </button>
      <ul class="dropdown-menu text-center w-100" aria-labelledby="statusDropdown">
        <!-- Kész option -->
        <li v-if="!['Meghiúsult', 'Kész', 'Bejelentve'].includes(status)">
          <a class="dropdown-item" @click="openSecondModal(Done, { status: 'Kész' })">Kész</a>
        </li>

        <!-- Meghiúsult option -->
        <li v-if="!['Meghiúsult', 'Kész', 'Bejelentve'].includes(status)">
          <a class="dropdown-item" @click="openSecondModal(Failed, { status: 'Meghiúsult' })">Meghiúsult</a>
        </li>

        <!-- Beszerzés szükséges option, only when status is 'Folyamatban' -->
        <li v-if="status === 'Folyamatban'">
          <a class="dropdown-item" @click="openSecondModal(Supply, { status: 'Beszerzés szükséges' })">Beszerzés szükséges</a>
        </li>

        <!-- Folyamatban option, only when status is 'Beszerzésre vár' -->
        <li v-if="status === 'Beszerzésre vár'">
          <a class="dropdown-item" @click="openSecondModal(InProgress, { status: 'Folyamatban' })">Folyamatban</a>
        </li>
      </ul>
    </div>
  </div>



  <button type="button" class="btn btn-secondary mx-1 my-2" @click="closeModal">Bezárás</button>
</div>



<!-- Second Modal -->
<div v-if="showSecondModal" class="secondmodal-overlay" @click="closeSecondModal">
  <div class="bg" @click.stop>
    <div class="secondmodal-content wider-modal">
      <div class="secondmodal-header">
      </div>
      <div class="secondmodal-body">
        <div class="mb-3">
        <label for="komment" class="form-label">Komment (opcionális)</label>
        <textarea 
          :class="['form-control', isDarkMode ? 'dark-textbox' : '']" 
          id="komment" 
          v-model="komment" 
          rows="3" 
          maxlength="300" 
          @input="adjustTextareaHeight($event); setCookie('komment', komment);" 
          required>
        </textarea>
      </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary mx-1" @click="confirmAction">Megerősítés</button>
        <button type="button" class="btn btn-secondary mx-1" @click="closeSecondModal">Mégse</button>

      </div>
    </div>
  </div>
</div>


        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { Dropdown } from 'bootstrap';

export default {
  data() {
    return {
      bugs: [],
      selectedBug: {},
      showModal: false,
      isDarkMode: false,
      showFilters: false,
      searchTerm: '',
      sortKey: '',
      sortOrder: 'asc',
      selectedPriorities: [],
      selectedLabels: [],
      selectedStatuses: [],
      selectedRooms: [],
      usersWithRoles: [],
      role: sessionStorage.getItem('role') || '',
      selectedUser: null,
      assignedTo: '',
      status: '',
      loggedInUser: sessionStorage.getItem('username') || '', // Get the logged-in user's username from sessionStorage
      showSecondModal: false, // State for the second modal
    actionToConfirm: null,   // Holds the action to confirm
    actionData: null, // To hold the action-specific data
    };
  },
  computed: {
    uniquePriorities() {
      return [...new Set(this.bugs.map(bug => bug.priority).sort())];
    },
    uniqueLabels() {
      return [...new Set(this.bugs.map(bug => bug.label))];
    },
    uniqueStatuses() {
      return [...new Set(this.bugs.map(bug => bug.status).sort())];
    },
    uniqueRooms() {
      return [...new Set(this.bugs.map(bug => bug.room).sort())];
    },
    photoCount() {
      return this.selectedBug.photos ? this.selectedBug.photos.length : 0;
    },
    filteredBugs() {

      
let filtered = this.bugs.filter(bug => {
  // Apply text search
  const searchTermLower = this.searchTerm.toLowerCase();
  const matchesSearch = bug.name.toLowerCase().includes(searchTermLower);


  // Apply filters
  const matchesPriority = !this.selectedPriorities.length || this.selectedPriorities.includes(bug.priority);
  const matchesLabel = !this.selectedLabels.length || this.selectedLabels.includes(bug.label);
  const matchesStatus = !this.selectedStatuses.length || this.selectedStatuses.includes(bug.status);
  const matchesRoom = !this.selectedRooms.length || this.selectedRooms.includes(bug.room);

  const statusNotCompletedOrFailed = bug.status !== "Kész" && bug.status !== "Meghiúsult";

  return matchesSearch && matchesPriority && matchesLabel && matchesStatus && matchesRoom && statusNotCompletedOrFailed;

  
});





// Sorting logic based on sortKey and sortOrder
return filtered.sort((a, b) => {
  let compareA, compareB;

  switch (this.sortKey) {
    case 'name':
    case 'room':
    case 'reportedBy':
      compareA = a[this.sortKey].toLowerCase();
      compareB = b[this.sortKey].toLowerCase();
      if (compareA < compareB) return this.sortOrder === 'asc' ? -1 : 1;
      if (compareA > compareB) return this.sortOrder === 'asc' ? 1 : -1;
      return 0;

    case 'priority':
      compareA = a.priority;
      compareB = b.priority;
      return this.sortOrder === 'asc' ? compareA - compareB : compareB - compareA;

    case 'reportedAt':
      compareA = new Date(a.reportedAt);
      compareB = new Date(b.reportedAt);
      return this.sortOrder === 'asc' ? compareA - compareB : compareB - compareA;

    default:
      return 0; // Default sorting if no key is selected
  }
});
}
},
  mounted() {
    this.fetchBugs();
    this.fetchUsersWithRoles();
    this.isDarkMode = localStorage.getItem('theme') === 'dark';
    window.addEventListener('theme-changed', this.updateTheme);
  },
  beforeDestroy() {
    window.removeEventListener('theme-changed', this.updateTheme);
  },
  methods: {
    async fetchBugs() {
      console.log(this.userRole)
      try {
        const response = await fetch('http://localhost:4500/api/hibakKiir');
        if (!response.ok) throw new Error('Network response was not ok');

        const data = await response.json();

        this.bugs = data.map(bug => ({
          id: bug.ID,
          name: bug['Hiba neve'],
          priority: bug['Prioritás'],
          priorityColor: this.getPriorityColor(bug['Prioritás']),
          label: bug['Címke'],
          status: bug['Státusz'],
          badgeClass: bug['Státusz'] === 'Bejelentve' ? 'badge-reported' :
              bug['Státusz'] === 'Folyamatban' ? 'badge-progress' :
                  bug['Státusz'] === 'Beszerzésre vár' ? 'badge-supply' : '',

          room: bug['Terem'],
          reportedBy: bug['Bejelentette'],
          reportedAt: new Date(bug['Bejelentés ideje']).toLocaleString('hu-HU'),
          assignedTo: bug['assignedTo'],
          description: bug['Hiba leírása'],
          hibaIdopont: bug['Hiba ideje'] ? new Date(bug['Hiba ideje']).toLocaleString('hu-HU') : "N/A", // Fallback if missing
          photos: bug.photos ? bug.photos.split(',').map(photo => `http://localhost:4500/uploads/${photo.trim()}`) : [] // Ensure the correct URL format
          
        }));
      } catch (error) {
        console.error('Error fetching bug data:', error);
      }
      
    },
    toggleFilterVisibility() {
      this.showFilters = !this.showFilters;
    },

    openPhoto(photo) {
      // Logic to open a larger view of the image
      const imgWindow = window.open(photo, '_blank');
      imgWindow.focus(); // Focus on the new window
    },
    sortBy(key) {
      if (this.sortKey === key) {
        // If the same column is clicked, toggle the sort order
        this.sortOrder = this.sortOrder === 'asc' ? 'desc' : 'asc';
      } else {
        // If a new column is clicked, set it as the sorting key and default to ascending
        this.sortKey = key;
        this.sortOrder = 'asc';
      }
    },
    getPriorityColor(priority) {
      switch (priority) {
        case 1: return 'darkgreen';
        case 2: return 'lightgreen';
        case 3: return 'yellow';
        case 4: return 'orange';
        case 5: return 'red';
        default: return '';
      }
    },
    updateTheme() {
      this.isDarkMode = localStorage.getItem('theme') === 'dark';
    },
    openModal(bug) {
      this.selectedBug = bug;
      this.showModal = true;
     this.assignedTo = this.selectedBug.assignedTo
     this.status = this.selectedBug.status

    },
    closeModal() {
      this.showModal = false;
      this.selectedUser = null; 
    },
    openSecondModal(action, data) {
      this.showSecondModal = true; // Show the second modal
      this.actionToConfirm = action; // Store the action to confirm
      this.actionData = data; // Store any additional data needed for the action
    },
    closeSecondModal() {
      this.showSecondModal = false; // Close the second modal
      this.actionData = null; // Clear the action data
      this.komment ='';
    },
    async confirmAction() {
      if (this.actionToConfirm) {
        try {
          await this.actionToConfirm(this.actionData); // Pass the action data to the async function
        } catch (error) {
          console.error('Error executing action:', error);
          alert('There was an error executing the action.');
        }
      }
      this.closeSecondModal(); // Close the modal
    },
    async Komment() {
      try {
        // Send a PUT request to update the status of the selected bug to "kész"
        const response = await fetch(`http://localhost:4500/api/addComment/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({komment: this.komment, modosito: this.loggedInUser }),
        });

        if (!response.ok) {
          throw new Error('Failed to update log');
        }
        console.log(this.loggedInUser);
        this.fetchBugs(); // Refresh the list to reflect the updated status
      } catch (error) {
        console.error('Error updating log:', error);
        alert('Failed to update the log.');
      }
    },
    async Done(data) {
      try {
        // Send a PUT request to update the status of the selected bug to "kész"
        const response = await fetch(`http://localhost:4500/api/updateStatus/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ status : 'Kész', komment: this.komment, modosito: this.loggedInUser }),
        });

        if (!response.ok) {
          throw new Error('Failed to update status');
        }

        // Update the frontend after a successful response
        this.selectedBug.status = 'kész';
        alert('Status successfully updated to "kész".');
        this.fetchBugs(); // Refresh the list to reflect the updated status
      } catch (error) {
        console.error('Error updating status:', error);
        alert('Failed to update the status.');
      }
    },

    async Failed(data) {
      try {
        // Send a PUT request to update the status of the selected bug to "kész"
        const response = await fetch(`http://localhost:4500/api/updateStatus/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ status : 'Meghiúsult', komment: this.komment, modosito: this.loggedInUser  }),
        });

        if (!response.ok) {
          throw new Error('Failed to update status');
        }

        // Update the frontend after a successful response
        this.selectedBug.status = 'Meghiúsult';
        alert('Status successfully updated to "Meghiúsult".');
        this.fetchBugs(); // Refresh the list to reflect the updated status
      } catch (error) {
        console.error('Error updating status:', error);
        alert('Failed to update the status.');
      }
    },

    async Supply(data) {
      try {
        // Send a PUT request to update the status of the selected bug to "kész"
        const response = await fetch(`http://localhost:4500/api/updateStatus/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ status : 'Beszerzésre vár', komment: this.komment, modosito: this.loggedInUser  }),
        });

        if (!response.ok) {
          throw new Error('Failed to update status');
        }

        // Update the frontend after a successful response
        this.selectedBug.status = 'Beszerzésre vár';
        alert('Status successfully updated to "Beszerzésre vár".');
        this.fetchBugs(); // Refresh the list to reflect the updated status
      } catch (error) {
        console.error('Error updating status:', error);
        alert('Failed to update the status.');
      }
    },

    async InProgress(data) {
      try {

        // Send a PUT request to update the status of the selected bug to "kész"
        const response = await fetch(`http://localhost:4500/api/updateStatus/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ status : 'Folyamatban', komment: this.komment, modosito: this.loggedInUser  }),
        });

        if (!response.ok) {
          throw new Error('Failed to update status');
        }

        // Update the frontend after a successful response
        this.selectedBug.status = 'Folyamatban';
        alert('Status successfully updated to "Folyamatban".');
        this.fetchBugs(); // Refresh the list to reflect the updated status
      } catch (error) {
        console.error('Error updating status:', error);
        alert('Failed to update the status.');
      }
      
    },
    async takeTask() {
      const username = sessionStorage.getItem('username'); // Get logged-in user's username

      if (!username) {
        alert('No user logged in'); // Error handling if username is not available
        return;
      }

      // Update the selected bug with the assigned user
      try {
        const response = await fetch(`http://localhost:4500/api/updateAssignedTo/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ assignedTo: username, komment: this.komment, modosito: this.loggedInUser  }), // Send the assigned user to backend
        });

        if (!response.ok) {
          throw new Error('Failed to assign the task');
        }

        // Update the frontend after successful response
        this.selectedBug.assignedTo = username;
        alert('Task successfully assigned to you.');
        this.komment = ''; // Clear komment after assignment
        this.fetchBugs();
      } catch (error) {
        console.error('Error assigning task:', error);
        alert('Failed to assign the task.');
      }
    },
    async fetchUsersWithRoles() {
      try {
        const response = await fetch('http://localhost:4500/api/usersWithRoles');
        if (!response.ok) throw new Error('Failed to fetch users');

        const data = await response.json();
        console.log(data);
        this.usersWithRoles = data; // Store the users in the array
      } catch (error) {
        console.error('Error fetching users:', error);
      }
    },
    selectUser(userName) {
    this.selectedUser = userName; // Set the selected user

    // Close the dropdown
    const dropdownElement = this.$refs.dropdownButton; // Reference to the dropdown button
    const dropdown = Dropdown.getInstance(dropdownElement); // Get the instance of the dropdown

    if (dropdown) {
      dropdown.hide(); // Close the dropdown
    } else {
      // If the dropdown instance does not exist, create it and then hide it
      const newDropdown = new Dropdown(dropdownElement);
      newDropdown.hide(); // Now hide the dropdown
    }
  },
    async assignTaskTo(selectedUser) {
      // Function to assign the selected user to the task
      try {
        const response = await fetch(`http://localhost:4500/api/updateAssignedTo/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ assignedTo: selectedUser, komment: this.komment, modosito: this.loggedInUser }),
        });

        if (!response.ok) throw new Error('Failed to assign task');
        this.selectedBug.assignedTo = selectedUser;
        his.komment = ''; // Clear komment after assignment
        alert(`Task assigned to ${selectedUser}`);
        this.fetchBugs(); // Refresh the list to reflect the new assignment
      } catch (error) {
        console.error('Error assigning task:', error);
      }
      
    },
    

  }
};
</script>


<style>
.reported-bugs-container {
  max-width: 900px;
  margin: 0 auto;
}

.search-input {
  width: 200px;
  border: solid 2px #4285f4;
}

.filter-icon {
  font-size: 1.5rem;
  color: #4285f4;
}

.table thead th {
  background-color: #f8f9fa;
  font-weight: bold;
  padding-left: 2em;
  text-align: left;
}

.table tbody td {
  padding-left: 2em;
  text-align: left;
}

.priority-container {
  display: flex;
  align-items: center;
}

.priority-bar {
  display: inline-block;
  width: 50px;
  height: 4px;
  margin-right: 5px;
}

.priority-bar.darkgreen {
  background-color: darkgreen;
}

.priority-bar.lightgreen {
  background-color: lightgreen;
}

.priority-bar.yellow {
  background-color: yellow;
}

.priority-bar.orange {
  background-color: #ff8c00;
}

.priority-bar.red {
  background-color: red;
}

.badge {
  display: inline-block;
  width: 120px;
  text-align: center;
  padding: 0.5rem 0.5rem;
  font-size: 0.9rem;
  font-weight: bold;
  border-radius: 0.5rem;
}

.badge-reported {
  background-color: #f7a611;
  color: #ffffff;
}

.badge-progress {
  background-color: #4169E1;
  color: #ffffff;
}

.badge-supply {
  background-color: brown;
  color: #ffffff;
}

.badge-check {
  background-color: rgb(10, 231, 220);
  color: #ffffff;
}



.table tbody td.status-column {
  width: 150px;
  text-align: center;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  max-width: 100%;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background: white !important;
  padding: 2rem;
  border-radius: 2vh !important;
  max-width: 80vw;
  min-width: 60vw;
  width: 100%;
  z-index: 1000;
}

.secondmodal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  max-width: 100%;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.secondmodal-content {
  background: white !important;
  padding: 2rem;
  border-radius: 2vh !important;
  max-width: 40vw;
  min-width: 30vw;
  width: 100%;
  z-index: 1000;
}

@media (max-width: 767.98px) { /* Adjust breakpoint as needed */
    .wider-modal {
        max-width: 100%; /* Make it full width */
        min-width: 100%  !important;
        width: 100%; /* Ensure width is set to 100% */
        margin: 0; /* Remove margin */
        padding: 2rem;
    }
}

.drown-kioszt {
  min-width: 100px !important;
}

.description {
  max-width: 100%;
  /* Ensure it takes full width of the column */
  height: auto;
  /* Let it grow automatically */
  overflow: hidden;
  /* Prevent overflow */
  word-wrap: break-word;
  /* Break long words if necessary */
}

.description-content {
  padding: 0.5rem;
  /* Add some padding for aesthetics */
  white-space: normal;
  /* Allow text to wrap onto new lines */
}


.photo-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  /* Two columns */
  gap: 10px;
  /* Space between photos */

  margin-bottom: 2rem;
}

.photo-item {
  cursor: pointer;
  /* Indicate that the item is clickable */
}

.photo-item img {
  width: 120px;
  /* Make the image take the full width of the item */
  height: 120px;
  /* Maintain aspect ratio */
  border-radius: 0.5rem;
  /* Optional: Rounded corners */
}

.image-thumbnail {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border: none !important;
  /* Remove the border */
  box-shadow: none !important;
  /* Remove any shadow */
  padding: 0 !important;
  /* Ensure no padding */
  margin: 0;
  /* Make sure there is no margin */
  background-color: transparent;
  /* Remove background color */
}


.photo_box {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}

.carousel-item {
  max-width: fit-content;
  max-height: fit-content;
  margin: 2%;
  object-fit: contain;
  /* Maintain aspect ratio and contain within the box */
  width: 100%;
  /* Take full width */
  height: 25vh;
  /* Fixed height */
}

.modal-title {
  padding-bottom: 1em;
}


.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.modal-footer {
  text-align: right;
}
.fixed-width {
  width: 10rem; /* Set to the desired width for the button */
}
.tooltip-custom {
  position: absolute;
  background-color: #fcc913;
  /* Background color for light mode */
  color: #000000;
  /* Text color for light mode */
  padding: 8px;
  border-radius: 4px;
  top: -3.5rem;
  /* Adjust according to your layout */
  left: 50%;
  /* Center the tooltip */
  transform: translateX(-50%);
  /* Ensure centering */
  z-index: 1000;
  white-space: nowrap;
  font-size: 14px;
  text-align: center;
  /* Center the text */
}

#done{
  background-color: #35b821;
  border: none;
}

#failed{
  background-color: red;
  border: none;
}

#supply{
  background-color: brown;
  border: none;
}


/* DARK MODE */


.dark-mode .table {
  background-color: #222;
  /* Set table background to dark gray */
  color: white;
  /* Default text color for the table */
}

.dark-mode .table thead th {
  background-color: #444;
  /* Table header background for dark mode */
  color: white;
  /* Text color for table header */
}

.dark-mode .table tbody {
  background-color: #222;
  /* Set tbody background color for dark mode */
}

.dark-mode .table tbody td {
  background-color: #222;
  /* Set table cell background color for dark mode */
  color: white;
  /* Text color for table cells */
}

.dark-mode .badge {
  background-color: #555;
  /* Badge background color for dark mode */
  color: white;
  /* Badge text color for dark mode */
}

.dark-mode .badge-reported {
  background-color: #f7a611;
  color: #ffffff;
}

.dark-mode .badge-progress {
  background-color: #4169E1;
  color: #ffffff;
}

.dark-mode .badge-supply {
  background-color: brown;
  color: #ffffff;
}

.dark-mode .badge-check {
  background-color: rgb(10, 231, 220);
  color: #ffffff;
}

/* Adjust hover effect for table rows in dark mode */
.dark-mode .table tbody tr:hover {
  background-color: #444;
  /* Change hover background color for dark mode */
}

/* Adjust hover effect for table rows in dark mode */
.dark-mode .table tbody tr {
  border-bottom: 1px solid grey;
  /* Set row borders to grey in dark mode */
}

/* Ensure that the table rows have a grey border in dark mode */
.dark-mode .table tbody tr {
  border-color: grey;
  /* Change the color of the border between rows */
}

/* Modal styles for dark mode */
.dark-mode .modal-content {
  background-color: #444 !important;
  /* Dark background for modal */
  color: white;
  /* Text color for modal */
  border-radius: 2vh;
}

.dark-mode .modal-header {
  background-color: #444;
  /* Header background for modal */
  color: white;
  /* Text color for modal header */
}

.dark-mode .modal-footer {
  background-color: #444;
  /* Footer background for modal */
  color: white;
  /* Text color for modal footer */
}


/* Change the line between the data and the headers to grey in dark mode */
.dark-mode .table thead th {
  border-bottom: 1px solid grey;
  /* Grey border for the header */
}

/* Change the border color of the table rows in dark mode */
.dark-mode .table tbody tr {
  border-color: grey;
  /* Change the color of the border between rows */
}

/* Ensure that the table rows have a grey border in dark mode */
.dark-mode .table tbody tr {
  border-color: grey;
  /* Change the color of the border between rows */
}


/* Change the line between the data and the headers to grey in dark mode */
.dark-mode .table thead th {
  border-bottom: 1px solid grey;
  /* Grey border for the header */
}

.dark-mode .search-input {
  background-color: #A9A9A9;
  /* Light gray background */
  color: white;
  /* White text */
  border-color: black;
  /* Keep the same blue border */
}

.dark-mode .search-input::placeholder {
  color: white;
  /* Make placeholder text white as well */
}
.dark-mode #done{
  background-color: #35b821;
  border: none;
}

.dark-mode #failed{
  background-color: red;
  border: none;
}

.dark-mode #supply{
  background-color: brown;
  border: none;
}

.filters-container {
  width: 100%;
  padding: 1rem;
}

.filters-wrapper {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  justify-content: flex-end;
}

.filter-dropdown {
  margin: 0;
  /* Remove default margin */
}

/* Update FilterDropDown styling */
#FilterDropDown {
  width: 7vw;
  min-width: 100px;
  /* Ensure minimum width on small screens */
  padding: 0.5rem;
  white-space: nowrap;
}

/* Media query for smaller screens */
@media screen and (max-width: 768px) {
  .filters-wrapper {
    flex-direction: column;
    align-items: stretch;
  }

  .filter-dropdown {
    width: 100%;
  }

  #FilterDropDown {
    width: 100%;
    /* Full width on mobile */
  }

  /* Adjust dropdown menu position on mobile */
  .dropdown-menu {
    width: 100%;
    /* Full width dropdowns on mobile */
  }
}

@media screen and (max-width: 768px) {
  .hide-mobile {
    display: none !important;
  }

  .table thead th,
  .table tbody td {
    padding-left: 1em;
    padding-right: 1em;
  }

  .priority-container {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    white-space: nowrap;
  }

  .priority-bar {
    width: 30px; /* Slightly smaller on mobile */
  }

  /* Ensure the table takes full width on mobile */
  .table-responsive {
    width: 100%;
    margin-bottom: 0;
  }

  /* Adjust the container padding for mobile */
  .reported-bugs-container {
    padding: 0 10px;
  }

  /* Ensure the "No results" message spans correct number of columns */
  tr:last-child td[colspan="7"] {
    column-span: 2;
  }
}
</style>
