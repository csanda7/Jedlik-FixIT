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

<!-- Feladat kész állapotba helyezése -->
<div v-if=" loggedInUser === assignedTo  && !['Meghiúsult', 'Kész', 'Bejelentve'].includes(status) ">
  <button
    type="button"
    class="btn btn-primary mx-1"
    id="done"
    @click="Done"
  >
    Kész
  </button>
  </div>


  <!-- Feladat meghíusult állapotba helyezése -->
  <div v-if=" loggedInUser === assignedTo  && !['Meghiúsult', 'Kész', 'Bejelentve'].includes(status) ">
  <button
    type="button"
    class="btn btn-primary mx-1"
    id="failed"
    @click="Failed"
  >
    Meghiúsult
  </button>
  </div>

  <!-- Feladat Beszerzés szükséges állapotba helyezése -->
  <div v-if="loggedInUser === assignedTo && !['Kész', 'Meghiúsult', 'Bejelentve', 'Beszerzésre vár'].includes(status)">
  <button
    type="button"
    class="btn btn-primary mx-1"
    id="supply"
    @click="Supply"
  >
  Beszerzés szükséges
  </button>
  </div>

  <button type="button" class="btn btn-secondary mx-1 my-2" @click="closeModal">Bezárás</button>
</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      bugs: [],
      selectedBug: {},
      showModal: false,
      isDarkMode: false,
      showFilters: false,
      selectedPriorities: [],
      selectedLabels: [],
      selectedStatuses: [],
      selectedRooms: [],
      usersWithRoles: [],
      searchTerm: '',
      sortKey: '',
      sortOrder: 'asc',
      showTooltip: false,
      loggedInUser: sessionStorage.getItem('username') || '', // Get the logged-in user's username from sessionStorage
      assignedTo: '',
      status: '',
    };
  },
  computed: {
    uniquePriorities() {
      return [...new Set(this.bugs.map(bug => bug.priority))];
    },
    uniqueLabels() {
      return [...new Set(this.bugs.map(bug => bug.label))];
    },
    uniqueStatuses() {
      return [...new Set(this.bugs.map(bug => bug.status))];
    },
    uniqueRooms() {
      return [...new Set(this.bugs.map(bug => bug.room))];
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

  const statusNotCompletedOrFailed = (bug.status === "Folyamatban" || bug.status === "Beszerzésre vár") && bug.assignedTo === this.loggedInUser;

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
    this.isDarkMode = localStorage.getItem('theme') === 'dark';
    window.addEventListener('theme-changed', this.updateTheme);
  },
  beforeDestroy() {
    window.removeEventListener('theme-changed', this.updateTheme);
  },
  methods: {
    async fetchBugs() {
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
                      bug['Státusz'] === 'Beszerzésre vár' ? 'badge-supply' :
                      bug['Státusz'] === 'Folyamatban' ? 'badge-progress' : '',
          room: bug['Terem'],
          reportedBy: bug['Bejelentette'],
          reportedAt: new Date(bug['Bejelentés ideje']).toLocaleString('hu-HU'),
          assignedTo: bug['assignedTo'],
          description: bug['Hiba leírása'],
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
    },
    async Done() {
      try {
        // Send a PUT request to update the status of the selected bug to "kész"
        const response = await fetch(`http://localhost:4500/api/updateStatus/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ status : 'Kész' }),
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
    async Failed() {
      try {
        // Send a PUT request to update the status of the selected bug to "kész"
        const response = await fetch(`http://localhost:4500/api/updateStatus/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ status : 'Meghiúsult' }),
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
    async Supply() {
      try {
        // Send a PUT request to update the status of the selected bug to "kész"
        const response = await fetch(`http://localhost:4500/api/updateStatus/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ status : 'Beszerzésre vár' }),
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
    
    }
  }
};
</script>



<style>
.dark-mode .card {
  background-color: #333;
  /* Card background for dark mode */
  color: white;
  /* Text color inside card */
}
/* Dark mode button styles */
.dark-mode .btn-primary {
  background-color: #007bff;
  /* Keep primary button color */
  border-color: #007bff;
  /* Border color for primary button */
}

.dark-mode .btn-secondary {
  background-color: #636363;
  /* Dark mode secondary button color */
  color: white;
  /* Text color for secondary button */
}

.dark-mode .btn-secondary:hover {
  background-color: #4285f4;
  /* Change hover color for secondary button */
  color: white;
  /* Text color on hover */
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
