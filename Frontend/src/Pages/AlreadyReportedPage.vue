<template>
    <div class="reported-bugs-container container mt-5">
      <div class="card shadow-sm">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h1 class="mb-0">Bejelentett Hibák</h1>
          <div class="user-actions d-flex">
            <input type="text" class="form-control search-input me-3" placeholder="Keresés..." />
            <i class="fas fa-filter filter-icon"></i>
          </div>
        </div>
        <div class="card-body p-0">
          <table class="table table-hover">
            <thead>
              <tr>
                <th>Hiba neve</th>
                <th>Prioritás</th>
                <th>Címke</th>
                <th>Terem</th>
                <th>Bejelentette</th>
                <th>Bejelntés ideje</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Törött billentyűzet</td>
                <td>
                  <div class="priority-container">
                    <span class="priority-bar yellow"></span>
                    <span>3</span>
                  </div>
                </td>
                <td>
                  <span class="badge badge-hardware">HARDVER</span>
                </td>
                <td>116</td>
                <td>Fütty Imre</td>
                <td>2024-09-26 16:12</td>
              </tr>
              <tr>
                <td>Windows kékhalál</td>
                <td>
                  <div class="priority-container">
                    <span class="priority-bar red"></span>
                    <span>5</span>
                  </div>
                </td>
                <td>
                  <span class="badge badge-software">SZOFTVER</span>
                </td>
                <td>203</td>
                <td>Csó Ronáldó</td>
                <td>2024-09-27 10:25</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="d-flex justify-content-center mt-3">
        <button class="btn btn-primary">Vissza</button>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        searchQuery: ''
      };
    },
    methods: {
      goBack() {
        this.$router.go(-1); // Navigates back to the previous page
      }
    }
  };
  </script>
  
  <style scoped>
  .reported-bugs-container {
    max-width: 900px;
    margin: 0 auto; /* Center align */
  }
  
  .card-header {
    background-color: #4285f4;
    color: white;
    padding: 1.2rem;
    border-bottom: none;
  }
  
  .search-input {
    width: 200px;
  }
  
  .filter-icon {
    font-size: 1.5rem;
    color: #4285f4;
  }
  
  .table thead th {
    background-color: #f8f9fa;
    font-weight: bold;
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
    background-color: #d1b3ff;
    color: #ffffff;
  }
  
  .badge-software {
    background-color: #ffa73e;
    color: #ffffff;
  }
  
  .btn-primary {
    background-color: #4285f4;
    border-color: #4285f4;
  }
  
  .btn-primary:hover {
    background-color: #356cc1;
  }
  </style>
  