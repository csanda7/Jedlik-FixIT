<template>
  <div class="reported-bugs-container container mt-5">
    <div class="card shadow-sm">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h2 class="mb-0 h2">BEJELENTETT HIBÁK</h2>
        <div class="user-actions d-flex">
          <input
            type="text"
            class="form-control search-input me-3"
            placeholder="Keresés..."
          />
          <i class="fas fa-filter filter-icon"></i>
        </div>
      </div>
      <div class="card-body p-0">
        <table class="table table-hover p-4">
          <thead>
            <tr>
              <th>Hiba neve</th>
              <th>Prioritás</th>
              <th>Címke</th>
              <th>Státusz</th>
              <th>Terem</th>
              <th>Bejelentette</th>
              <th>Bejelntés ideje</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(bug, index) in bugs"
              :key="index"
              @click="openModal(bug)"
              style="cursor: pointer"
            >
              <td>{{ bug.name }}</td>
              <td>
                <div class="priority-container">
                  <span :class="['priority-bar', bug.priorityColor]"></span>
                  <span>{{ bug.priority }}</span>
                </div>
              </td>
              <td>
                <span :class="['badge', bug.badgeClass]">{{ bug.label }}</span>
              </td>
              <td>{{ bug.status }}</td>
              <td>{{ bug.room }}</td>
              <td>{{ bug.reportedBy }}</td>
              <td>{{ bug.reportedAt }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Modal -->
    <div v-if="showModal" class="modal-overlay ">
      <div class="bg">
      <div class="modal-content  ">
        <div class="modal-header  ">
          <h3 class="modal-title  ">{{ selectedBug.name }}</h3>
        </div>
        <div class="modal-body">
          <p><strong>Prioritás:</strong> {{ selectedBug.priority }}</p>
          <p><strong>Címke:</strong> {{ selectedBug.label }}</p>
          <p><strong>Státusz:</strong> {{ selectedBug.status }}</p>
          <p><strong>Terem:</strong> {{ selectedBug.room }}</p>
          <p><strong>Bejelentette:</strong> {{ selectedBug.reportedBy }}</p>
          <p><strong>Bejelentés ideje:</strong> {{ selectedBug.reportedAt }}</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" @click="closeModal">Bezárás</button>
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
      bugs: [
        {
          name: 'Törött billentyűzet',
          priority: 3,
          priorityColor: 'yellow',
          label: 'HARDVER',
          badgeClass: 'badge-hardware',
          status: 'Folyamatban',
          room: '116',
          reportedBy: 'Nagy Gergő',
          reportedAt: '2024-09-26 16:12',
        },
        {
          name: 'Windows kékhalál',
          priority: 5,
          priorityColor: 'red',
          label: 'SZOFTVER',
          badgeClass: 'badge-software',
          status: 'Folyamatban',
          room: '203',
          reportedBy: 'Csó Ronáldó',
          reportedAt: '2024-09-27 10:25',
        },
      ],
      selectedBug: {},
      showModal: false,
    };
  },
  methods: {
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
.reported-bugs-container {
  max-width: 900px;
  margin: 0 auto;
}

.h2 {
  color: rgb(59, 59, 59);
  padding: 0.5em;
}

.card-header {
  background-color: #f93943;
  color: white;
  padding: 1.2rem;
  border-bottom: none;
}

.card-header h1 {
  margin-left: -10px;
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

.priority-bar.yellow {
  background-color: #ffc107;
}

.priority-bar.red {
  background-color: #dc3545;
}

.badge {
  padding: 0.5rem 1rem;
  font-size: 0.8rem;
  font-weight: bold;
  border-radius: 0.5rem;
}

.badge-hardware {
  background-color: #9757f8;
  color: #ffffff;
}

.badge-software {
  background-color: #ffa73e;
  color: #ffffff;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  max-width: 100%;
  background: rgba(0, 0, 0, 0.6); /* Dark background overlay */
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  padding:2rem;
  border-radius: 8px;
  max-width: 1000px;
  min-width: 500px;
  width: 100%;
  box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
  z-index: 1000;
}

.modal-title{
  padding-bottom: 1em;
}
.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.bg{
  background-color: rgb(255,255,255);
  z-index: 500;
}

.btn-close {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
}

.modal-footer {
  text-align: right;
}

.btn-secondary {
  background-color: #636363;
  color: white;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.btn-secondary:hover {
  background-color: #4285f4;
  color: white;
}
</style>
