<template>
  <div :class="['reported-bugs-container', { 'dark-mode': isDarkMode }, 'container', 'mt-5']">
    <div :class="[ 'card', 'shadow-sm', { 'dark-mode': isDarkMode }]">
      <div :class="['card-header', { 'dark-mode': isDarkMode }, 'd-flex', 'justify-content-between', 'align-items-center']">
        <h2 class="my-2 h2">Lezárt hibák</h2>
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



   <!-- Eseménynapló megnyitása -->
   <button
          type="button"
          class="btn btn-secondary me-auto"
          @click="openLogModal(selectedBugId)"
        >
          Eseménynapló
        </button>  
            
            <!-- Komment írása -->
  <button
    type="button"
    class="btn btn-primary mx-1"
    @click="openCommentModal(komment)"
  >
    Megjegyzés
  </button> 

  <button v-if="role === 'muszakivezeto'" type="button" class="btn btn-reassign mx-1 my-2" @click="openCommentModal(reAssign)">Újrakiosztás</button>
  <button type="button" class="btn btn-secondary mx-1 my-2" @click="closeModal">Bezárás</button>
</div>




<!-- Comment Modal -->
<div v-if="showCommentModal" class="Commentmodal-overlay" @click="closeCommentModal">
  <div class="bg" @click.stop>
    <div class="Commentmodal-content wider-modal" :class="{'dark-mode': isDarkMode}">
      <div class="Commentmodal-header">
      </div>
      <div class="Commentmodal-body">
        <div class="mb-3">
        <label for="komment" class="form-label">Megjegyzés</label>
        <textarea 
          :class="['form-control', isDarkMode ? 'dark-textbox' : '']" 
          id="komment" 
          v-model="komment" 
          rows="3" 
          maxlength="300" 
          >
        </textarea>
      </div>
      </div>
      <div class="modal-footer">
        <button  type="button" class="btn btn-primary mx-1" @click="confirmAction">Küldés</button>
        <button type="button" class="btn btn-secondary mx-1" @click="closeCommentModal">Mégse</button>

      </div>
    </div>
  </div>
</div>


<!-- Log Modal -->
<div v-if="showLogModal" class="modal-overlay" @click="closeLogModal">
    <div class="bg" @click.stop>
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">Eseménynapló</h3>
        </div>
        <div class="modal-body">
          <!-- Displaying log entries in a table -->
          <table class="table table-bordered">
            <thead>
              <tr>
                <th>Státusz</th>
                <th>Megjegyzés</th>
                <th>Frissítve</th>
                <th>Módosító</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="log in logEntries" :key="log.ID">
                <td>{{ log.LStatus }}</td>
                <td>{{ log.Komment }}</td>
                <td>{{ new Date(log.Updated_at).toLocaleString() }}</td>
                <td>{{ log.modosito }}</td>
              </tr>
            </tbody>
          </table>
          <p v-if="logEntries.length === 0">Nincsenek elérhető események.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" @click="closeLogModal">Bezárás</button>
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
export default {
  data() {
    return {
      bugs: [],
      selectedBug: {},
      showModal: false,
      showCommentModal: false, 
      showLogModal: false,
      isDarkMode: false,
      showFilters: false,
      searchTerm: '',
      sortKey: '',
      selectedPriorities: [],
      selectedLabels: [],
      selectedStatuses: [],
      selectedRooms: [],
      usersWithRoles: [],
      sortOrder: 'asc',
      showTooltip: false,
      loggedInUser: sessionStorage.getItem('username') || '', // Get the logged-in user's username from sessionStorage
      role: sessionStorage.getItem('role') || '',
      assignedTo: '',
      status: '',
      actionToConfirm: null,   // Holds the action to confirm
      actionData: null, // To hold the action-specific data
      komment: '',
      logEntries: [], // Property to hold log entries
      komment: '',
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
      const exactStatuses = ["Meghiúsult","Kész"]
      return [...new Set(this.bugs.map(bug => bug.status))].filter(status => exactStatuses.includes(status));
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

        const statusNotCompletedOrFailed = bug.status === "Kész" || bug.status === "Meghiúsult";

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
    this.isDarkMode = sessionStorage.getItem('theme') === 'dark';
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
                      bug['Státusz'] === 'Kész' ? 'badge-done' :
                      bug['Státusz'] === 'Meghiúsult' ? 'badge-failed' : '',
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
      this.isDarkMode = sessionStorage.getItem('theme') === 'dark';
    },
    openModal(bug) {
      this.selectedBug = bug;
      this.showModal = true;
    },
    closeModal() {
      this.showModal = false;
    },
    openCommentModal(action, data) {
      this.showCommentModal = true; // Show the Comment modal
      this.actionToConfirm = action; // Store the action to confirm
      this.actionData = data; // Store any additional data needed for the action
    },
    closeCommentModal() {
      this.showCommentModal = false; // Close the Comment modal
      this.actionData = null; // Clear the action data
      this.komment ='';
    },
    async openLogModal() {
      this.showLogModal = true;
      await this.fetchLogEntries(); // Fetch log entries from the backend
    },
    closeLogModal() {
      this.showLogModal = false;
    },
  
    async confirmAction() {
      if (this.actionToConfirm) {
        try {
          await this.actionToConfirm(this.actionData); // Execute the action with its data
        } catch (error) {
          console.error('Error executing action:', error);
          alert('There was an error executing the action.');
        }
      }
      this.closeCommentModal();
    },

    // Method to add a comment to the selected bug
    async Komment() {
      // Check if the comment text box is empty
      if (!this.komment || this.komment.trim() === '') {
        alert('Please enter a comment before submitting.');
        return;
      }

      try {
        const response = await fetch(`http://localhost:4500/api/addComment/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ komment: this.komment, modosito: this.loggedInUser }),
        });

        if (!response.ok) throw new Error('Failed to update log');

        console.log('Comment added:', this.komment);
        this.fetchBugs(); // Refresh the list to reflect the updated comment
      } catch (error) {
        console.error('Error updating log:', error);
        alert('Failed to update the log.');
      }
    },

    // Method to reassign the bug
    async reAssign() {
      await this.updateStatus('Újból kiosztva');
    },

    // Method to update the bug's status
    async updateStatus(status) {
      try {
        const response = await fetch(`http://localhost:4500/api/updateStatusandAssigndTo/${this.selectedBug.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ status, komment: this.komment, modosito: this.loggedInUser }),
        });

        if (!response.ok) throw new Error(`Failed to update status to "${status}"`);

        this.selectedBug.status = status;
        alert(`Status successfully updated to "${status}".`);
        this.fetchBugs();
      } catch (error) {
        console.error(`Error updating status to "${status}":`, error);
        alert(`Failed to update the status to "${status}".`);
      }
    },
  }
};
</script>

<style scoped>

.badge-failed {
  background-color: red;
  color: #ffffff;
}

.badge-done {
  background-color: #35b821;
  color: #ffffff;
}

.dark-mode .badge-failed {
  background-color: red;
  color: #ffffff;
}

.dark-mode .badge-done {
  background-color: #35b821;
  color: #ffffff;
}

.btn-reassign {
  background-color: #007bff; /* kék háttérszín */
  color: #ffffff; /* fehér szöveg */
}
</style>