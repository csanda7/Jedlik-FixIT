<template>
  <div class="reported-bugs-container container mt-5">
    <div class="card shadow-sm">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h2 class="mb-0 h2">FELADATAIM</h2>
        <div class="user-actions d-flex">
          <input type="text" class="form-control search-input me-3" placeholder="Keresés..." />
          <i class="fas fa-filter filter-icon"></i>
        </div>
      </div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-hover p-4">
            <thead>
              <tr>
                <th>Hiba neve</th>
                <th>Prioritás</th>
                <th>Címke</th>
                <th>Státusz</th>
                <th>Terem</th>
                <th>Bejelentette</th>
                <th>Bejelentés ideje</th>
              </tr>
            </thead>
            <tbody>
  <tr v-for="(bug, index) in bugs" :key="index" @click="openModal(bug)" style="cursor: pointer">
    <td>{{ bug.name }}</td>
    <td>
      <div v-if="bug.priority === 0">
        Nincs prioritás
      </div>
      <div v-else class="priority-container">
        <span :class="['priority-bar', bug.priorityColor]"></span>
        <span>{{ bug.priority }}</span>
      </div>
    </td>
    <td>
     {{ bug.label }}
</td>
        <td calls="status-column"> <span :class="['badge', bug.badgeClass]">{{bug.status }}</span></td>
    <td>{{ bug.room }}</td>
    <td>{{ bug.reportedBy }}</td>
    <td>{{ bug.reportedAt }}</td>
  </tr>
</tbody>


          </table>
        </div>
      </div>
    </div>

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
        <div v-if="selectedBug.priority === 0"  class="ms-2">Nincs prioritás</div>
        <div v-else class="priority-container ms-2">
      <span :class="['priority-bar', selectedBug.priorityColor]"></span>
      <span>{{ selectedBug.priority }}</span>
      </div>

      </div>
      <p><strong>Címke:</strong> {{ selectedBug.label }}</p>
      <div class="d-flex align-items-center mb-2">
        <strong>Státusz: </strong>
        <span :class="['badge', selectedBug.badgeClass,'ms-2',  { 'dark-mode': isDarkMode }] ">{{ selectedBug.status }}</span>
      </div>
      <p><strong>Terem:</strong> {{ selectedBug.room }}</p>
      <p><strong>Bejelentette:</strong> {{ selectedBug.reportedBy }}</p>
      <p><strong>Bejelentés ideje:</strong> {{ selectedBug.reportedAt }}</p>
      <p v-if="selectedBug.assignedTo"><strong>Feladatot elvállalta:</strong> {{ selectedBug.assignedTo }}</p>
    </div>
    <div class="col-md-4 description">
      <p><strong>Hiba leírása:</strong> {{ selectedBug.description }}</p>
    </div>
    <div class="col-md-4 photo_box">
      <div id="bugCarousel" class="carousel slide" data-bs-ride="carousel">
        <!-- Add carousel items here for photos if applicable -->
      </div>
    </div>
  </div>
</div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary mx-1" @click="closeModal">Bezárás</button>
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
      bugs: [], // Initially empty array
      selectedBug: {},
      showModal: false,
    };
  },
  mounted() {
    // Fetch bugs from backend when the component is mounted
    this.fetchBugs();
  },
  methods: {
    async fetchBugs() {
      try {
        const response = await fetch('http://localhost:4500/api/hibakKiir');
        if (!response.ok) throw new Error('Network response was not ok');
        
        const data = await response.json();
        console.log('API Response:', data); // Log the entire response to check if ID is present
        
        const username = sessionStorage.getItem('username'); // Get logged-in user's username

        // Filter bugs based on assignedTo
        this.bugs = data
          .filter(bug => bug.assignedTo === username) // Only show bugs assigned to the logged-in user
          .map(bug => ({
            id: bug.ID,
            name: bug['Hiba neve'],
            priority: bug['Prioritás'],
            priorityColor: this.getPriorityColor(bug['Prioritás']),
            label: bug['Címke'],
            status: bug['Státusz'],
            badgeClass: bug['Státusz'] === 'Bejelentve' ? 'badge-reported' :
                        bug['Státusz'] === 'Kész' ? 'badge-done' :
                        bug['Státusz'] === 'Folyamatban' ? 'badge-progress' : '',
            room: bug['Terem'],
            reportedBy: bug['Bejelentette'],
            reportedAt: new Date(bug['Bejelentés ideje']).toLocaleString('hu-HU'),
            assignedTo: bug['assignedTo'], // Ensure this is fetched correctly
            description: bug['Hiba leírása']
          }));

      } catch (error) {
        console.error('Error fetching bug data:', error);
      }
    },

    getPriorityColor(priority) {
      switch (priority) {
        case 1:
          return 'darkgreen';
        case 2:
          return 'lightgreen';
        case 3:
          return 'yellow';
        case 4:
          return 'orange';
        case 5:
          return 'red';
        default:
          return ''; // No color for 0 or invalid values
      }
    },

    openModal(bug) {
      this.selectedBug = bug;
      this.showModal = true; // Show the modal
    },
    closeModal() {
      this.showModal = false; // Hide the modal
    },

  },
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


</style>
