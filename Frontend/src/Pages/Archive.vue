<template>
  <div :class="['reported-bugs-container', { 'dark-mode': isDarkMode }, 'container', 'mt-5']">
    <div :class="['card', 'shadow-sm', { 'dark-mode': isDarkMode }]">
      <div
        :class="['card-header', { 'dark-mode': isDarkMode }, 'd-flex', 'justify-content-between', 'align-items-center']">
        <h2 class="my-2 h2">Bejelentett hibák</h2>
        <div class="user-actions d-flex">
          <input type="text" class="form-control search-input me-3" placeholder="Keresés..." v-model="searchTerm" />
          <button class="btn btn-secondary" type="button" @click="toggleFilterVisibility">
            <i class="bi bi-funnel-fill"></i>
          </button>
          <button v-if="areFiltersApplied" class="btn btn-danger ms-3" @click="resetFilters">
            <i class="bi bi-trash-fill"></i>
          </button>
        </div>
      </div>
      <!-- Updated filters section with responsive design -->
      <div v-if="showFilters" class="filters-container">
        <div class="filters-wrapper">
          <!-- Priority Filter -->
          <div class="filter-dropdown">
            <button class="btn btn-secondary dropdown-toggle" id="FilterDropDown" type="button"
              data-bs-toggle="dropdown" aria-expanded="false">
              Prioritás
            </button>
            <ul class="dropdown-menu">
              <li v-for="priority in uniquePriorities" :key="priority" class="px-3 py-1">
                <label>
                  <input class="form-check-input" type="checkbox" :value="priority" v-model="selectedPriorities" /> {{
                    priority }}
                </label>
              </li>
            </ul>
          </div>

          <!-- Label Filter -->
          <div class="filter-dropdown">
            <button class="btn btn-secondary dropdown-toggle" id="FilterDropDown" type="button"
              data-bs-toggle="dropdown" aria-expanded="false">
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
            <button class="btn btn-secondary dropdown-toggle" id="FilterDropDown" type="button"
              data-bs-toggle="dropdown" aria-expanded="false">
              Státusz
            </button>
            <ul class="dropdown-menu">
              <li v-for="status in uniqueStatuses" :key="status" class="px-3 py-1">
                <label>
                  <input class="form-check-input" type="checkbox" :value="status" v-model="selectedStatuses" /> {{
                    status }}
                </label>
              </li>
            </ul>
          </div>

          <!-- Room Filter -->
          <div class="filter-dropdown">
            <button class="btn btn-secondary dropdown-toggle" id="FilterDropDown" type="button"
              data-bs-toggle="dropdown" aria-expanded="false">
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
        <div class="modal-content"  s>
          <div class="modal-header">
            <h3 class="modal-title">{{ selectedBug.name }}</h3>
          </div>
          <div class="modal-body">
            <div class="row">
              <div :class="{
              'col-md-6': selectedBug.photos.length === 0,
              'col-md-4': selectedBug.photos.length > 0
                }">
                <div class="info-row">
                  <strong>Prioritás: </strong>
                  <div v-if="!isEditing">
                    <div v-if="selectedBug.priority === 0" class="ms-2">Nincs prioritás</div>
                    <div v-else class="priority-container my-1">
                      <span :class="['priority-bar', selectedBug.priorityColor]"></span>
                      <span>{{ selectedBug.priority }}</span>
                    </div>
                  </div>
                  <div v-if="isEditing">
                    <select v-model="selectedBug.priority" class="form-select  my-1">
                      <option v-for="n in 6" :key="n - 1" :value="n - 1">{{ n - 1 }}</option>
                    </select>
                  </div>
                </div>
                <div class="info-row"><strong>Címke:</strong> {{ selectedBug.label }}</div>
                <div class="info-row">
                  <strong>Státusz: </strong>
                  <span :class="['badge', selectedBug.badgeClass, { 'dark-mode': isDarkMode }]">{{
                    selectedBug.status }}</span>
                </div>
                <p class="info-row"><strong>Terem:</strong> {{ selectedBug.room }}</p>
                <p class="info-row"><strong>Bejelentette:</strong> {{ selectedBug.reportedBy }}</p>
                <p class="info-row"><strong>Bejelentés ideje:</strong> {{ selectedBug.reportedAt }}</p>
                <div class="info-row" v-if="selectedBug.assignedTo">
                  <strong>Megbízott:</strong>
                  <p v-if="!isEditing && selectedBug.assignedTo" class="my-1">{{ selectedBug.assignedTo }}</p>
                  <div v-if="isEditing && selectedBug.assignedTo != null">
                    <select v-model="selectedBug.assignedTo" class="form-select my-1">
                      <option v-for="user in usersWithRoles" :key="user" :value="user">{{ user }}</option>
                    </select>
                  </div>
                </div>
                <p v-if="selectedBug.deadline != null && !isEditing" class="info-row">
                  <strong>Határidő:</strong> {{ new Date(selectedBug.deadline).toLocaleString([], {
                    year: 'numeric',
                    month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit' }) }}
                </p>
                <div v-if="isEditing" class="info-row">
                  <label><strong>Határidő:</strong></label>
                  <input type="datetime-local" v-model="selectedBug.deadline" class="form-control" />
                </div>
              </div>
              <div :class="{
                description: true,
                'ml-2':true,
              'col-md-6': selectedBug.photos.length === 0,
              'col-md-12 my-4': selectedBug.photos.length > 0 && isLandscape,
              'col-md-4': selectedBug.photos.length > 0 && !isLandscape
                }">
                <p><strong>Hiba leírása:</strong></p>
                <div class="description-content">{{ selectedBug.description }}</div>
              </div>
              <div :class="{
                photo_box: true,
              'col-md-12 my-4': isLandscape,
              'col-md-4':  !isLandscape
                }">
                <div class="photo-grid">
                  <div v-for="(photo, index) in selectedBug.photos" :key="index" class="photo-item">
                    <img :src="photo" class="image-thumbnail" :alt="'Bug photo ' + index" @click="openPhoto(photo)" />
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div v-if="showPhotoModal" class="carousel-modal-overlay" @click="closePhotoModal">
            <div class="carousel-modal-content" @click.stop>
              <span class=" btn btn-dark carousel-close" @click="closePhotoModal">&times;</span>
              <button type="button" class="btn btn-dark carousel-prev py-4" @click="prevPhoto">&lt;</button>
              <img :src="selectedPhoto" alt="Selected Bug Photo" class="carousel-photo" />
              <button type="button" class="btn btn-dark carousel-next py-4" @click="nextPhoto">&gt;</button>
            </div>
          </div>


          <div class="modal-footer">



            <!-- Eseménynapló megnyitása -->
            <button v-if="!isEditing" type="button" class="btn btn-primary" v-bind:class="isMobile ? 'phoneViewButton' : 'me-auto'" @click="openLogModal(selectedBugId)">
              Eseménynapló
            </button>


            <!-- Komment írása -->
            <button v-if="!isEditing" type="button" class="btn btn-primary   " v-bind:class="isMobile ? 'phoneViewButton' : 'mx-1 equal-width'" @click="handleButtonClick">
              Megjegyzés
            </button>




            <button v-if="!isEditing" type="button" class="btn btn-secondary" v-bind:class="isMobile ? 'phoneViewButton' : 'mx-1 my-2 equal-width'" @click="closeModal">Bezárás</button>
          </div>




<!-- Comment Modal -->
<div v-if="showCommentModal" class="Commentmodal-overlay">
            <div class="bg" @click.stop>
              <div class="Commentmodal-content wider-modal" :class="{ 'dark-mode': isDarkMode }">
                <div class="Commentmodal-header">
                </div>
                <div class="Commentmodal-body">
                  <div class="mb-2">
                    <label v-if="iscommmentonly === true" for="komment"
                      class="form-label d-flex justify-content-between align-items-center">
                      Megjegyzés
                      <span class="small ms-4" :style="{ color: isDarkMode ? '#D3D3D3' : '#6c757d' }">
                        {{ komment.length }}/300
                      </span>
                    </label>
                    <label v-if="iscommmentonly === false" for="komment"
                      class="form-label d-flex justify-content-between align-items-center">
                      Megjegyzés (opcionális)
                      <span class="small ms-4" :style="{ color: isDarkMode ? '#D3D3D3' : '#6c757d' }">
                        {{ komment.length }}/300
                      </span>
                    </label>
                    <textarea :class="['form-control', isDarkMode ? 'dark-textbox' : '']" id="komment" v-model="komment"
                      rows="6" maxlength="300" @input="updateCharacterCount">
          </textarea>
                  </div>
                </div>
                <div class="modal-footer">
                  <div class="d-flex justify-content-center flex-wrap">
  <button type="button" class="btn btn-primary mx-1" @click="confirmAction">Küldés</button>
  <button type="button" class="btn btn-secondary mx-1" @click="closeCommentModal">Mégse</button>
</div>

                </div>
              </div>
            </div>
          </div>


          <!-- Log Modal -->
          <div v-if="showLogModal" class="logmodal-overlay" @click="closeLogModal" >
            <div class="bg logmodal-bg" @click.stop :class="{ 'dark-mode': isDarkMode }">
              <div class="logmodal-content" :class="{ 'dark-mode': isDarkMode }">
                <div class="logmodal-header">
                  <h3 class="logmodal-title">Eseménynapló</h3>
                </div>
                <div class="logmodal-body">
                  <div v-if="logEntries.length > 0">
                    <div v-for="log in sortedLogEntries" :key="log.logid" class="logmodal-entry">
                      <div class="logmodal-row">
                        <div v-if="log.logUpdated_at" class="logmodal-item">
                          <strong>Frissítve</strong>
                          <p>{{ new Date(log.logUpdated_at).toLocaleString([], {
                            year: 'numeric', month: '2-digit', day:
                              '2-digit', hour: '2-digit', minute: '2-digit' }) }}</p>

                        </div>
                        <div v-if="log.logmodosito" class="logmodal-item">
                          <strong>Módosító</strong>
                          <p>{{ log.logmodosito }}</p>
                        </div>
                        <div v-if="log.logStatus" class="logmodal-item">
                          <strong>Státusz</strong>
                          <span :class="['badge', getBadgeClass(log.logStatus), { 'dark-mode': isDarkMode }]">{{
                            log.logStatus }}</span>
                        </div>
                        <div v-if="log.logassignedTo" class="logmodal-item">
                          <strong>Megbízott</strong>
                          <p>{{ log.logassignedTo }}</p>
                        </div>
                        <div v-if="log.logdeadLine" class="logmodal-item">
                          <strong>Határidő</strong>
                          <p>{{ new Date(log.logdeadLine).toLocaleString([], {
                            year: 'numeric', month: '2-digit', day:
                              '2-digit', hour: '2-digit', minute: '2-digit' }) }}</p>
                        </div>
                        <div v-if="log.logpriority" class="logmodal-item">
                          <strong>Prioritás</strong>
                          <div class="priority-container">
                            <span :class="['priority-bar', getPriorityColor(log.logpriority)]"></span>
                            <span class="priority-text">{{ log.logpriority }}</span>
                          </div>
                        </div>
                        <div v-if="log.logKomment" class="description">
                          <strong>Hozzászólás</strong>
                          <p class="description-content">{{ log.logKomment }}</p>
                        </div>
                      </div>
                      <hr v-if="logEntries.length > 1" />
                    </div>
                  </div>
                  <p v-else>Nincsenek elérhető események.</p>
                </div>
                <div class="logmodal-footer">
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
      showPhotoModal: false,
      selectedPhoto: null,
      selectedPhotoIndex: 0,
      showCommentModal: false,
      showLogModal: false,
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
      selectedUser: '',
      assignedTo: '',
      deadline: '',
      status: '',
      loggedInUser: sessionStorage.getItem('username') || '',
      actionToConfirm: null,
      actionData: null,
      komment: '',
      logEntries: [], 
      isEditing: false,
      iscommmentonly: false,
      isMobile: false,
      isLandscape: false,
      isPortrait: window.matchMedia("(orientation: portrait)").matches,
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
    areFiltersApplied() {
      return (
        this.selectedPriorities.length > 0 ||
        this.selectedLabels.length > 0 ||
        this.selectedStatuses.length > 0 ||
        this.selectedRooms.length > 0
      );
    },
    photoCount() {
      return this.selectedBug.photos ? this.selectedBug.photos.length : 0;
    },
    sortedLogEntries() {
      return this.logEntries.sort((a, b) => {
        return new Date(b.logUpdated_at) - new Date(a.logUpdated_at);
      });
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
    this.fetchUsersWithRoles();
    this.isDarkMode = sessionStorage.getItem('theme') === 'dark';
    window.addEventListener('theme-changed', this.updateTheme);
  },
  beforeDestroy() {
    window.removeEventListener('theme-changed', this.updateTheme);
  },
 
  created() {
    this.orientationOrResizeListener = () => {
      this.isMobile = window.matchMedia("(max-width: 600px)").matches;
    };
    this.viewChange = () => {
      this.isLandscape = window.matchMedia("(max-height: 600px) and (max-width: 900px)").matches;

    };

    window.addEventListener("resize", this.orientationOrResizeListener);
    window.matchMedia("(orientation: portrait)").addEventListener("change", this.orientationOrResizeListener);

    window.addEventListener("resize", this.viewChange);
    window.matchMedia("(orientation: landscape)").addEventListener("change", this.viewChange);
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.orientationOrResizeListener);
    window.matchMedia("(orientation: portrait)").removeEventListener("change", this.orientationOrResizeListener);

    window.removeEventListener("resize", this.viewChange);
    window.matchMedia("(orientation: landscape)").removeEventListener("change", this.viewChange);
  },
  methods: {
    checkMobileView() {
  if (window.innerWidth <= 600) {
    this.isMobile = true;
  } else {
    this.isMobile = false;
  }
},
updateTheme() {
  this.isDarkMode = sessionStorage.getItem('theme') === 'dark';
},

/* Fetch and Data Management */

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
              bug['Státusz'] === 'Beszerzésre vár' ? 'badge-supply' :
                bug['Státusz'] === 'Újból kiosztva' ? 'badge-resent' :
                  bug['Státusz'] === 'Kész' ? 'badge-done' :
                    bug['Státusz'] === 'Meghiúsult' ? 'badge-failed' : '',

          room: bug['Terem'],
          reportedBy: bug['Bejelentette'],
          reportedAt: new Date(bug['Bejelentés ideje']).toLocaleString([], { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit' }),
          assignedTo: bug['assignedTo'],
          description: bug['Hiba leírása'],
          deadline: bug['Határidő'],
          photos: bug.photos ? bug.photos.split(',').map(photo => `http://localhost:4500/uploads/${photo.trim()}`) : [] // Ensure the correct URL format,

        }));
      } catch (error) {
        console.error('Error fetching bug data:', error);
      }
},
async fetchUsersWithRoles() {
  try {
    const response = await fetch('http://localhost:4500/api/usersWithRoles');
    if (!response.ok) throw new Error('Failed to fetch users');

    this.usersWithRoles = await response.json();
  } catch (error) {
    console.error('Error fetching users:', error);
  }
},
async fetchLogEntries() {
  try {
    const response = await fetch(`http://localhost:4500/api/logs/${this.selectedBug.id}`);
    if (!response.ok) throw new Error('Failed to fetch log entries');

    const logData = await response.json();
    this.logEntries = logData.map(log => ({
      logid: log.ID,
      logStatus: log.Status,
      logKomment: log.Komment,
      logUpdated_at: log.Updated_at,
      logmodosito: log.modosito,
      logassignedTo: log.assignedTo,
      logdeadLine: log.deadLine,
      logpriority: log.priority
    }));

  } catch (error) {
    console.error('Error fetching log entries:', error);
  }
},

/* Filter and Sort */

resetFilters() {
  this.selectedPriorities = [];
  this.selectedLabels = [];
  this.selectedStatuses = [];
  this.selectedRooms = [];
},
toggleFilterVisibility() {
  this.showFilters = !this.showFilters;
},
sortBy(key) {
  if (this.sortKey === key) {
    this.sortOrder = this.sortOrder === 'asc' ? 'desc' : 'asc';
  } else {
    this.sortKey = key;
    this.sortOrder = 'asc';
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
    /* Main modal */

   openModal(bug) {
    this.selectedBug = bug;
    this.showModal = true;
    this.assignedTo = this.selectedBug.assignedTo;
    this.status = this.selectedBug.status;
    document.body.style.overflow = 'hidden';
    this.checkMobileView();
  },
  closeModal() {
    this.showModal = false;
    this.selectedUser = null;
    this.isEditing = false;
    document.body.style.overflow = '';
  },
  closeLogModal() {
    this.showLogModal = false;
  },

  handleButtonClick() {
    this.iscommmentonly = true;
    this.openCommentModal(this.Komment);
  },

  /* Comment modal */

  openCommentModal(action, data) {
    this.showCommentModal = true;
    this.actionToConfirm = action;
    this.actionData = data;
  },
  closeCommentModal() {
    this.showCommentModal = false;
    this.actionData = null;
    this.komment = '';
    this.iscommmentonly = false;
  },
  async confirmAction() {
    if (this.actionToConfirm) {
      try {
        await this.actionToConfirm(this.actionData);
      } catch (error) {
        console.error('Error executing action:', error);
        alert('There was an error executing the action.');
      }
    }
    this.closeCommentModal();
    this.closeModal();
    this.openModal(this.selectedBug);
  },
  async Komment() {
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
  
  /* Log modal */

  async openLogModal() {
    this.showLogModal = true;
    await this.fetchLogEntries(); // Fetch log entries from the backend
  },
  closeLogModal() {
    this.showLogModal = false;
  },

  /* Photo modal */

  openPhoto(photo, index) {
    this.showPhotoModal = true;
    this.selectedPhoto = photo;
    this.selectedPhotoIndex = index;
  },
  closePhotoModal() {
    this.showPhotoModal = false;
    this.selectedPhoto = null;
  },
  prevPhoto() {
    if (this.selectedPhotoIndex > 0) {
      this.selectedPhotoIndex--;
    } else {
      this.selectedPhotoIndex = this.selectedBug.photos.length - 1;
    }
    this.selectedPhoto = this.selectedBug.photos[this.selectedPhotoIndex];
  },
  nextPhoto() {
    if (this.selectedPhotoIndex < this.selectedBug.photos.length - 1) {
      this.selectedPhotoIndex++;
    } else {
      this.selectedPhotoIndex = 0;
    }
    this.selectedPhoto = this.selectedBug.photos[this.selectedPhotoIndex];
  },

  /* Utility */
  
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
  getBadgeClass(status) {
    switch (status) {
      case 'Bejelentve':
        return 'badge-reported';
      case 'Folyamatban':
        return 'badge-progress';
      case 'Beszerzésre vár':
        return 'badge-supply';
      case 'Újból kiosztva':
        return 'badge-resent';
      case 'Kész':
        return 'badge-done';
      case 'Meghiúsult':
        return 'badge-failed';
    }
  },
  selectUser(userName) {
    this.selectedUser = userName;
    const dropdownElement = this.$refs.dropdownButton;
    const dropdown = bootstrap.Dropdown.getInstance(dropdownElement) || new bootstrap.Dropdown(dropdownElement);
    dropdown.hide();
  },
  }
};
</script>

<style>


</style>