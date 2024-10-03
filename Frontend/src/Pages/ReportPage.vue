<template>
    <div class="container mt-5">
      <div class="card p-4 shadow">
        <h1 class="text-center">Hiba Bejelentése</h1>
        <form @submit.prevent="submitForm">
          <div class="mb-3">
            <label for="bugName" class="form-label">Hiba Megnevezése</label>
            <input type="text" class="form-control" id="bugName" v-model="bugName" placeholder="Add meg a hiba nevét">
          </div>
          <div class="mb-3">
            <label for="priority" class="form-label">Prioritás: {{ priority }}</label>
            <input type="range" class="form-range" min="1" max="5" v-model="priority" id="priority">
          </div>
          <div class="mb-3">
            <label for="bugDescription" class="form-label">Hiba Leírása</label>
            <textarea class="form-control" id="bugDescription" v-model="bugDescription" rows="3" placeholder="Add meg a hiba leírását"></textarea>
          </div>
          <div class="mb-3">
            <label for="photo" class="form-label">Fotó Feltöltése</label>
            <input type="file" class="form-control" id="photo" @change="onFileChange">
          </div>
          <div class="mb-3">
            <label for="location" class="form-label">Helyszín</label>
            <input type="text" class="form-control" id="location" v-model="location" placeholder="Add meg a helyszínt">
          </div>
          <div class="d-grid gap-2">
            <button type="submit" class="btn btn-primary">Hiba Beküldése</button>
            <button type="button" class="btn btn-secondary" @click="goBack">Vissza</button>
          </div>
        </form>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        bugName: '',
        priority: 1,
        bugDescription: '',
        photo: null,
        location: ''
      };
    },
    methods: {
      onFileChange(event) {
        this.photo = event.target.files[0];
      },
      submitForm() {
        console.log("Bug Name:", this.bugName);
        console.log("Priority:", this.priority);
        console.log("Bug Description:", this.bugDescription);
        console.log("Location:", this.location);
        if (this.photo) {
          console.log("Photo Uploaded:", this.photo.name);
        }
      },
      goBack() {
        console.log("Going back...");
      }
    }
  };
  </script>
  
  <style scoped>
  .card {
    max-width: 600px;
    margin: 0 auto; /* Center align */
  }
  
  .form-range {
    width: 100%;
  }
  
  .btn-primary {
    background-color: #4285f4;
    border-color: #4285f4;
  }
  
  .btn-secondary {
    background-color: #6c757d;
  }
  </style>
  